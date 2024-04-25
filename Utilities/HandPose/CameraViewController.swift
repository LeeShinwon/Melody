import UIKit
import AVFoundation
import Vision
import SwiftUI


class CameraViewController: UIViewController {
    
   @ObservedObject var handGestureViewModel = HandGestureViewModel.shared
    
    private var cameraView: CameraView!
    
    private let videoDataOutputQueue = DispatchQueue(label: "CameraFeedDataOutput", qos: .userInteractive)
    
    private var cameraFeedSession: AVCaptureSession?
    
    private var handPoseRequest = VNDetectHumanHandPoseRequest()
    
    
    private var evidenceBuffer = [HandGestureProcessor.PointsPair]()
    private var lastObservationTimestamp = Date()
    
    
    private var leftHandGestureProcessor = HandGestureProcessor()
    private var rightHandGestureProcessor = HandGestureProcessor()
    
    
    private let leftHandLabel: UILabel = {
        let label = UILabel()
        label.text = "Left Hand"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let rightHandLabel: UILabel = {
        let label = UILabel()
        label.text = "Right Hand"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func loadView() {
        // Initialize your CameraView here and assign it to the view property
        cameraView = CameraView(frame: UIScreen.main.bounds)
        view = cameraView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handPoseRequest.maximumHandCount = 2
        
        AudioPlayerHandGestureManager.shared.loadSounds()
        
        setupHandLabels()
        
        rightHandGestureProcessor.didChangeLittleStateClosure = { [weak self] state in
            guard let self = self else { return }
            if state == .pinched {
                AudioPlayerHandGestureManager.shared.playSound(named: "do")
                self.handGestureViewModel.currentHandGesture = "do"
            } else {
                AudioPlayerHandGestureManager.shared.stopSound(named: "do")
            }
            
            handGestureViewModel.isDoPinched  = state == .pinched ? true:false
            
        }
        rightHandGestureProcessor.didChangeRingStateClosure = { [weak self] state in
            guard let self = self else { return }
            if state == .pinched {
                AudioPlayerHandGestureManager.shared.playSound(named: "re")
                self.handGestureViewModel.currentHandGesture = "re"
            } else {
                AudioPlayerHandGestureManager.shared.stopSound(named: "re")
            }
            
            handGestureViewModel.isRePinched  = state == .pinched ? true:false
        }
        rightHandGestureProcessor.didChangeMiddleStateClosure = { [weak self] state in
            guard let self = self else { return }
            if state == .pinched {
                AudioPlayerHandGestureManager.shared.playSound(named: "mi")
                self.handGestureViewModel.currentHandGesture = "mi"
            } else {
                AudioPlayerHandGestureManager.shared.stopSound(named: "mi")
            }
            
            handGestureViewModel.isMiPinched  = state == .pinched ? true:false
        }
        rightHandGestureProcessor.didChangeIndexStateClosure = { [weak self] state in
            guard let self = self else { return }
            if state == .pinched {
                AudioPlayerHandGestureManager.shared.playSound(named: "fa")
                self.handGestureViewModel.currentHandGesture = "fa"
            } else {
                AudioPlayerHandGestureManager.shared.stopSound(named: "fa")
            }
            
            handGestureViewModel.isFaPinched  = state == .pinched ? true:false
        }
        
        leftHandGestureProcessor.didChangeIndexStateClosure = { [weak self] state in
            guard let self = self else { return }
            if state == .pinched {
                AudioPlayerHandGestureManager.shared.playSound(named: "sol")
                self.handGestureViewModel.currentHandGesture = "sol"
            } else {
                AudioPlayerHandGestureManager.shared.stopSound(named: "sol")
            }
            
            handGestureViewModel.isSolPinched  = state == .pinched ? true:false
        }
        
        leftHandGestureProcessor.didChangeMiddleStateClosure = { [weak self] state in
            guard let self = self else { return }
            if state == .pinched {
                AudioPlayerHandGestureManager.shared.playSound(named: "ra")
                self.handGestureViewModel.currentHandGesture = "ra"
            } else {
                AudioPlayerHandGestureManager.shared.stopSound(named: "ra")
            }
            
            handGestureViewModel.isRaPinched  = state == .pinched ? true:false
        }
        
        leftHandGestureProcessor.didChangeRingStateClosure = { [weak self] state in
            guard let self = self else { return }
            if state == .pinched {
                AudioPlayerHandGestureManager.shared.playSound(named: "si")
                self.handGestureViewModel.currentHandGesture = "si"
            } else {
                AudioPlayerHandGestureManager.shared.stopSound(named: "si")
            }
            
            handGestureViewModel.isSiPinched  = state == .pinched ? true:false
        }
        
        leftHandGestureProcessor.didChangeLittleStateClosure = { [weak self] state in
            guard let self = self else { return }
            if state == .pinched {
                AudioPlayerHandGestureManager.shared.playSound(named: "highDo")
                self.handGestureViewModel.currentHandGesture = "highDo"
            } else {
                AudioPlayerHandGestureManager.shared.stopSound(named: "highDo")
            }
            
            handGestureViewModel.isHighDoPinched  = state == .pinched ? true:false
        }
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        do {
            if cameraFeedSession == nil {
                cameraView.previewLayer.videoGravity = .resizeAspectFill
                try setupAVSession()
                cameraView.previewLayer.session = cameraFeedSession
            }
            cameraFeedSession?.startRunning()
        } catch {
            AppError.display(error, inViewController: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cameraFeedSession?.stopRunning()
        super.viewWillDisappear(animated)
    }
    
    func setupAVSession() throws {
        // Select a front facing camera, make an input.
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            throw AppError.captureSessionSetup(reason: "Could not find a front facing camera.")
        }
        
        guard let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            throw AppError.captureSessionSetup(reason: "Could not create video de=vice input.")
        }
        
        let session = AVCaptureSession()
        session.beginConfiguration()
    
        session.sessionPreset = AVCaptureSession.Preset.high
        
        // Add a video input.
        guard session.canAddInput(deviceInput) else {
            throw AppError.captureSessionSetup(reason: "Could not add video device input to the session")
        }
        session.addInput(deviceInput)
        
        
        
        let dataOutput = AVCaptureVideoDataOutput()
        if session.canAddOutput(dataOutput) {
            session.addOutput(dataOutput)
            // Add a video data output.
            dataOutput.alwaysDiscardsLateVideoFrames = true
            dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            dataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            throw AppError.captureSessionSetup(reason: "Could not add video data output to the session")
        }
        session.commitConfiguration()
        cameraFeedSession = session
    }
    
    func setupHandLabels() {
        view.addSubview(leftHandLabel)
        view.addSubview(rightHandLabel)
        
        NSLayoutConstraint.activate([
            leftHandLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            leftHandLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rightHandLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            rightHandLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    

    
    
    func processPoints(thumbTip: CGPoint?, indexTip: CGPoint?, middleTip: CGPoint?, ringTip: CGPoint?, littleTip: CGPoint?, isLeftHand: Bool) {
        // Check that we have both points.
        guard let thumbPoint = thumbTip, let indexPoint = indexTip, let middlePoint = middleTip, let ringPoint = ringTip, let littlePoint = littleTip else {
            // If there were no observations for more than 2 seconds reset gesture processor.
            if Date().timeIntervalSince(lastObservationTimestamp) > 2 {
                if isLeftHand {
                    leftHandGestureProcessor.reset()
                } else {
                    rightHandGestureProcessor.reset()
                }
            }
            cameraView.showPoints([], color: .clear, isLeftHand: isLeftHand)
            return
        }
        
        // Convert points from AVFoundation coordinates to UIKit coordinates.
        let previewLayer = cameraView.previewLayer
        let thumbPointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: thumbPoint)
        let indexPointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: indexPoint)
        let middlePointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: middlePoint)
        let ringPointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: ringPoint)
        let littlePointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: littlePoint)
        
        let gestureProcessor = isLeftHand ? leftHandGestureProcessor : rightHandGestureProcessor
        
        // Process new points
        gestureProcessor.processPointsPair((thumbPointConverted, indexPointConverted, middlePointConverted, ringPointConverted, littlePointConverted))
        
        let pointsPair = gestureProcessor.lastProcessedPointsPair
        let states = [gestureProcessor.indexState, gestureProcessor.middleState, gestureProcessor.ringState, gestureProcessor.littleState]
        
        cameraView.showPoints([pointsPair.thumbTip, pointsPair.indexTip, pointsPair.middleTip, pointsPair.ringTip, pointsPair.littleTip], color: states.contains(.pinched) ? .green : .systemPink, isLeftHand: isLeftHand)
    }
}


extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        let handler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up, options: [:])
        do {
            
            try handler.perform([handPoseRequest])
            
            guard let observations = handPoseRequest.results, !observations.isEmpty else {
                return
            }
            
            var leftHandObservation = [VNHumanHandPoseObservation]()
            var rightHandObservation = [VNHumanHandPoseObservation]()
            
            for observation in observations {
                guard let wristPoint = try? observation.recognizedPoint(.wrist) else { continue }
                
                
                if wristPoint.location.x < 0.5 {
                    leftHandObservation.append(observation)
                }else{
                    rightHandObservation.append(observation)
                }
            }
            
            processHandObservations(leftHandObservation, isLeftHand: true)
            processHandObservations(rightHandObservation, isLeftHand: false)
            
            
        } catch {
            cameraFeedSession?.stopRunning()
            let error = AppError.visionError(error: error)
            DispatchQueue.main.async {
                error.displayInViewController(self)
            }
            
        }
    }
    private func processHandObservations(_ observations: [VNHumanHandPoseObservation], isLeftHand: Bool){

        guard let observation = observations.first else { return }
        var thumbTip: CGPoint?
        var indexTip: CGPoint?
        var middleTip: CGPoint?
        var ringTip: CGPoint?
        var littleTip: CGPoint?
        
        

        defer {
            DispatchQueue.main.sync {
                self.processPoints(thumbTip: thumbTip, indexTip: indexTip, middleTip: middleTip, ringTip: ringTip, littleTip: littleTip, isLeftHand: isLeftHand)
            }
        }
        
        do {
            
            let thumbPoints = try observation.recognizedPoints(.thumb)
            let indexFingerPoints = try observation.recognizedPoints(.indexFinger)
            let middleFingerPoints = try observation.recognizedPoints(.middleFinger)
            let ringFingerPoints = try observation.recognizedPoints(.ringFinger)
            let littleFingerPoints = try observation.recognizedPoints(.littleFinger)
            
            // Look for tip points.
            guard let thumbTipPoint = thumbPoints[.thumbTip], let indexTipPoint = indexFingerPoints[.indexTip], let middleTipPoint = middleFingerPoints[.middleTip], let ringTipPoint = ringFingerPoints[.ringTip], let littleTipPoint = littleFingerPoints[.littleTip] else {
                return
            }
            
            // Ignore low confidence points.
            guard thumbTipPoint.confidence > 0.3 && indexTipPoint.confidence > 0.3 && middleTipPoint.confidence > 0.3 && ringTipPoint.confidence > 0.3 && littleTipPoint.confidence > 0.3 else {
                return
            }
            // Convert points from Vision coordinates to AVFoundation coordinates.
            thumbTip = CGPoint(x: thumbTipPoint.location.x, y: 1 - thumbTipPoint.location.y)
            indexTip = CGPoint(x: indexTipPoint.location.x, y: 1 - indexTipPoint.location.y)
            middleTip = CGPoint(x: middleTipPoint.location.x, y: 1 - middleTipPoint.location.y)
            ringTip = CGPoint(x: ringTipPoint.location.x, y: 1 - ringTipPoint.location.y)
            littleTip = CGPoint(x: littleTipPoint.location.x, y: 1 - littleTipPoint.location.y)
            
            
        } catch {
            cameraFeedSession?.stopRunning()
            let error = AppError.visionError(error: error)
            DispatchQueue.main.async {
                error.displayInViewController(self)
            }
        }
    }
    
}


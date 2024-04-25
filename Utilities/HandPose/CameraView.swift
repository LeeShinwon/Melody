import UIKit
import AVFoundation

class CameraView: UIView {
    private var leftHandOverlayLayer = CAShapeLayer()
    private var rightHandOverlayLayer = CAShapeLayer()
    private var leftPointsPath = UIBezierPath()
    private var rightPointsPath = UIBezierPath()
    
    
    var previewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    private var dashedLineLayer: CAShapeLayer = {
        let dashedLineLayer = CAShapeLayer()
        dashedLineLayer.strokeColor = UIColor.black.cgColor
        dashedLineLayer.lineWidth = 2
        dashedLineLayer.lineDashPattern = [4, 4]
        
        return dashedLineLayer
    }()
    
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupOverlay()
        addDashedLine()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupOverlay()
        addDashedLine()
    }
    
    private func addDashedLine() {
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: bounds.midX, y: 0), CGPoint(x: bounds.midX, y: bounds.maxY)])
        dashedLineLayer.path = path
        layer.addSublayer(dashedLineLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dashedLineLayer.frame = bounds
        updateDashedLinePath()
        
    }
    
    private func updateDashedLinePath() {
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: bounds.midX, y: 0), CGPoint(x: bounds.midX, y: bounds.maxY)])
        dashedLineLayer.path = path
    }
    
    
    private func setupOverlay() {
        previewLayer.addSublayer(leftHandOverlayLayer)
        previewLayer.addSublayer(rightHandOverlayLayer)
    }
    
    func showPoints(_ points: [CGPoint], color: UIColor, isLeftHand: Bool) {
        let pointsPath = isLeftHand ? leftPointsPath : rightPointsPath
        let overlayLayer = isLeftHand ? leftHandOverlayLayer : rightHandOverlayLayer
        
        pointsPath.removeAllPoints()
        for point in points {
            pointsPath.move(to: point)
            pointsPath.addArc(withCenter: point, radius: 8, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        }
        overlayLayer.fillColor = color.cgColor
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        overlayLayer.path = pointsPath.cgPath
        CATransaction.commit()
    }
}



import CoreGraphics

class HandGestureProcessor {
    enum State {
        case pinched
        case apart
        case unknown
    }
    
    typealias PointsPair = (thumbTip: CGPoint, indexTip: CGPoint, middleTip: CGPoint, ringTip: CGPoint, littleTip: CGPoint)
    
    var indexState = State.unknown {
        didSet {
            didChangeIndexStateClosure?(indexState)
        }
    }
    var middleState = State.unknown {
        didSet {
            didChangeMiddleStateClosure?(middleState)
        }
    }
    var ringState = State.unknown {
        didSet {
            didChangeRingStateClosure?(ringState)
        }
    }
    var littleState = State.unknown {
        didSet {
            didChangeLittleStateClosure?(littleState)
        }
    }
    
    
    private let pinchMaxDistance: CGFloat = 40
    
    var didChangeIndexStateClosure: ((State) -> Void)?
    var didChangeMiddleStateClosure: ((State) -> Void)?
    var didChangeRingStateClosure: ((State) -> Void)?
    var didChangeLittleStateClosure: ((State) -> Void)?
    
    private (set) var lastProcessedPointsPair = PointsPair(.zero, .zero, .zero, .zero, .zero)
    
    
    
    func reset() {
        indexState = .unknown
        middleState = .unknown
        ringState = .unknown
        littleState = .unknown
        
    }
    
    func processPointsPair(_ pointsPair: PointsPair) {
        lastProcessedPointsPair = pointsPair
        
       
        let thumbIndexDistance = pointsPair.indexTip.distance(from: pointsPair.thumbTip)
        let thumbMiddleDistance = pointsPair.middleTip.distance(from: pointsPair.thumbTip)
        let thumbRingDistance = pointsPair.ringTip.distance(from: pointsPair.thumbTip)
        let thumbLittleDistance = pointsPair.littleTip.distance(from: pointsPair.thumbTip)
        

        indexState = thumbIndexDistance < pinchMaxDistance ? .pinched : .apart
        middleState = thumbMiddleDistance < pinchMaxDistance ? .pinched : .apart
        ringState = thumbRingDistance < pinchMaxDistance ? .pinched : .apart
        littleState = thumbLittleDistance < pinchMaxDistance ? .pinched : .apart
        
    }
    
}

// MARK: - CGPoint helpers

extension CGPoint {
    
    func distance(from point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }
}



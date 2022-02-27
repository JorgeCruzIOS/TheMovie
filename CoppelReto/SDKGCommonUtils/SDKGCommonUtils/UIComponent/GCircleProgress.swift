//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit


open class GCircleProgress: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func createCircularPath(endPointPercent: CGFloat, withSize: Int) {
        let centPercent = (((endPoint - startPoint) / 100 ) * endPointPercent) + startPoint
        // created circularPath for circleLayer and progressLayer
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: withSize, y: withSize), radius: CGFloat(withSize), startAngle: startPoint, endAngle: centPercent, clockwise: true)
        // circleLayer path defined to circularPath
        circleLayer.path = circularPath.cgPath
        // ui edits
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 3.0
        circleLayer.strokeEnd = 0.0
        circleLayer.strokeColor = GColorSingleton.WhiteColor.cgColor
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        
        // progressLayer path defined to circularPath
        progressLayer.path = circularPath.cgPath
        // ui edits
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 3.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = GColorSingleton.PrimaryColor.cgColor
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
    }
    
    public func progressAnimation(duration: TimeInterval) {
        // created circularProgressAnimation with keyPath
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // set the end time
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}

//
//  Contatore.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 02/10/2020.
//

import Foundation
import UIKit

protocol ContatoreDataSource {
    func fillPercentage() -> CGFloat
    func iconForChart() -> UIImage
    func animateLoading() -> Bool
}

class Contatore: UIView {
    private var logo: UIImageView!
    private var shapeLayer: CAShapeLayer!
    open var lineWidth: CGFloat = 6
    
    var dataSource: ContatoreDataSource? = nil
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI() {
        
        let halfSize:CGFloat = min( frame.width/2, frame.height/2)
        let imageSize: CGFloat = (min(frame.width, frame.height) - lineWidth)/2
        logo = UIImageView(frame: CGRect(x: halfSize-imageSize/2, y:halfSize-imageSize/2, width: imageSize, height: imageSize))
        self.addSubview(logo)
        logo.contentMode = .scaleAspectFit
        logo.tintColor = .label
        
        let percentage: CGFloat = {
            let value:CGFloat = (self.dataSource?.fillPercentage()) ?? 0
            if (value<0){
                return 0
            }
            return value/100
        }()
        
        
        let backgroundPath = UIBezierPath(
                        arcCenter: CGPoint(x:halfSize,y:halfSize),
                        radius: CGFloat( halfSize - (lineWidth/2) ),
                        startAngle: CGFloat(-Double.pi * 5/4),
                        endAngle:CGFloat(Double.pi/4),
                        clockwise: true)
            
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = backgroundPath.cgPath
        backgroundLayer.lineCap = .round
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = lineWidth
        layer.addSublayer(backgroundLayer)
        
        
        let circlePath = UIBezierPath(
                        arcCenter: CGPoint(x:halfSize,y:halfSize),
                        radius: CGFloat( halfSize - (lineWidth/2) ),
                        startAngle: CGFloat(-Double.pi * 5/4),
                        endAngle:CGFloat(Double.pi/4),
                        clockwise: true)
            
        shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(named: "primary")?.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeEnd = percentage
        layer.addSublayer(shapeLayer)
        
        logo.image = dataSource?.iconForChart()
        
        if(dataSource?.animateLoading() ?? false){
            animate(percentage: percentage)
        }
    }
    
    private func animate(percentage: CGFloat) {
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")

            // Set the animation duration appropriately
            animation.duration = 1.5
            animation.fromValue = 1
            animation.toValue = percentage

            // Do a linear animation (i.e. the speed of the animation stays the same)
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

            // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
            // right value when the animation ends.
            shapeLayer.strokeEnd = percentage

            // Do the actual animation
            shapeLayer.add(animation, forKey: "animateCircle")
    }
    
}

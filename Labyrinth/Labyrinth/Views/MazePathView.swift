//
//  MazePathView.swift
//  Labyrinth
//
//  Created by Khasanza on 6/8/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import UIKit

class MazePathView: UIView {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var lastCircleLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        drawCircle(direction: .east, shift: 5, color: UIColor.green)
    }
    func drawLine(direction: Direction) {
        lastCircleLayer.removeFromSuperlayer()
        drawCircle(direction: direction, shift: 0, color: UIColor.red)
        let s = CAShapeLayer()
        s.path = drawLine(point: CGPoint(x: x, y: y), direction: direction, size: 16).cgPath
        s.lineWidth = 2
        s.strokeColor = UIColor.red.cgColor
        layer.addSublayer(s)
        //animateShape(shapeLayer: s)
        //updateView()
        drawCircle(direction: direction, shift: 5, color: UIColor.green)
        
    }
    private func drawCircle(direction: Direction, shift: CGFloat, color: UIColor) {
        lastCircleLayer = CAShapeLayer()
        lastCircleLayer.path = circlePath(direction: direction, radius: 5, shift: shift).cgPath
        lastCircleLayer.fillColor = color.cgColor
        
        layer.addSublayer(lastCircleLayer)
        //animateShape(shapeLayer: lastCircleLayer)
        //updateView()
    }
    private func updateView() {
        layoutSubviews()
        layoutIfNeeded()
    }
    private func drawLine(point: CGPoint, direction: Direction, size: CGFloat) -> UIBezierPath {
        let line = UIBezierPath()
        line.move(to: point)
        addShift(direction: direction, shift: size)
        line.addLine(to: CGPoint(x: x, y: y))
        line.close()
        return line
    }
    private func circlePath(direction: Direction, radius: CGFloat, shift: CGFloat) -> UIBezierPath {
        let circlePath = UIBezierPath()
        addShift(direction: direction, shift: shift)
        let point = CGPoint(x: x, y: y)
        circlePath.addArc(withCenter: point, radius: radius, startAngle: -CGFloat(Double.pi), endAngle: -CGFloat(Double.pi / 2), clockwise: true)
        circlePath.addArc(withCenter: point, radius: radius, startAngle: -CGFloat(Double.pi / 2), endAngle: 0, clockwise: true)
        
        circlePath.addArc(withCenter: point, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        circlePath.addArc(withCenter: point, radius: radius, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: true)
        circlePath.close()
        return circlePath
    }
    private func addShift(direction: Direction, shift: CGFloat) {
        switch direction {
            case .north:
            y -= shift
            case .east:
            x += shift
            case .south:
            y += shift
            case .west:
            x -= shift
        }
    }
    func animateShape(shapeLayer: CAShapeLayer) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        
    }
}

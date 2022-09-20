//
//  TryingPathViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 6/24/22.
//

import UIKit

class TryingPathViewController: UIViewController {
    
    let percentage: [Double] = [0.1, 0.65, 0.25]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sWidth = UIScreen.main.bounds.width
        let sHeight = UIScreen.main.bounds.height
        
        let shWidth = sWidth / 2
        let shHeight = sHeight / 2
        
        let path1 = UIBezierPath()
        path1.cMove(x: shWidth, y: shHeight - 150)
        path1.cAddLine(x: sWidth - 20, y: shHeight + 150)
        path1.cAddLine(x: 20, y: shHeight + 150)
        
        let path2 = UIBezierPath()
        path2.cMove(x: shWidth - 50, y: shHeight - 50)
        path2.cAddQuadCurve(toX: shWidth + 50, toY: shHeight - 50, cpX: shWidth, cpY: shHeight + 50)

        let path3 = UIBezierPath()
        path3.cMove(x: 50, y: shHeight)
        path3.cAddCurve(toX: sWidth - 50, toY: shHeight, cp1X: shWidth, cp1Y: shHeight + 200, cp2X: shWidth, cp2Y: shHeight - 200)
        
        let rectangePath = UIBezierPath(rect: CGRect(x: shWidth - 50, y: shHeight - 50, width: 100, height: 100))
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: shWidth - 50, y: shHeight - 50, width: 100, height: 100))
        let roundedRect = UIBezierPath(roundedRect: CGRect(x: shWidth - 50, y: shHeight - 50, width: 100, height: 100), cornerRadius: 10.0)
        
        let headPath = UIBezierPath()
        headPath.move(to: CGPoint(x: 50, y: shHeight))
        headPath.addQuadCurve(to: CGPoint(x: sWidth - 50, y: shHeight - 100), controlPoint: CGPoint(x: shWidth - 50, y: shHeight - 150))
        headPath.addCurve(to: CGPoint(x: 50, y: shHeight), controlPoint1: CGPoint(x: sWidth + 50, y: shHeight + 150), controlPoint2: CGPoint(x: 100, y: shHeight + 250))
        headPath.close()
        
        let pieChart = UIBezierPath(ovalIn: CGRect(x: 20, y: shHeight - ((sWidth / 2) - 20), width: sWidth - 40, height: sWidth - 40))
        let middleHollow = UIBezierPath(ovalIn: CGRect(x: 70, y: shHeight - ((sWidth / 2) - 70), width: sWidth - 140, height: sWidth - 140))
        
        let fullCircle = 3.14 * 2
        
        let arcPath = UIBezierPath()
        arcPath.addArc(withCenter: CGPoint(x: shWidth, y: shHeight), radius: shWidth - 70, startAngle: 0, endAngle: fullCircle * 0.25, clockwise: true)
        
        let arcPath2 = UIBezierPath()
        arcPath2.addArc(withCenter: CGPoint(x: shWidth, y: shHeight), radius: shWidth - 70, startAngle: fullCircle * 0.25, endAngle: fullCircle * 0.5, clockwise: true)
         
        
//        self.view.layer.addPath(path: arcPath, lineWitdh: 4, fillColor: UIColor.clear.cgColor, strokeColor: UIColor.orange.cgColor)
//        self.view.layer.addPath(path: pieChart, lineWitdh: 0, fillColor: UIColor.black.cgColor)
//        self.view.layer.addPath(path: middleHollow, lineWitdh: 0, fillColor: UIColor.white.cgColor)
//        self.view.layer.addPath(path: arcPath, lineWitdh: 50, fillColor: UIColor.clear.cgColor, strokeColor: UIColor.red.cgColor)
//        self.view.layer.addPath(path: arcPath2, lineWitdh: 50, fillColor: UIColor.clear.cgColor, strokeColor: UIColor.blue.cgColor)
        self.view.makePieChart(percentages: percentage)
    }
}

extension UIView {
    func makePieChart(percentages: [Double], withGap: Double = 0.0075) {
        DispatchQueue.main.async {
            let centerPoint = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
            let radius = (self.frame.width / 2) - 70
            let fullCircle = 3.14159265359 * 2.0
            
            var startAngle = 0.0
            var endAngle = 0.0
            
            var percentageAngle: [Double] = []
            
            for percentage in percentages {
                percentageAngle.append((fullCircle * percentage) - (fullCircle * withGap))
            }
            
            for percentage in percentageAngle {
                endAngle = (startAngle + percentage)
                
                let arcPath = UIBezierPath()
                arcPath.addArc(withCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                self.layer.addPath(path: arcPath, lineWitdh: 50, strokeColor: UIColor.random.cgColor)
                
                startAngle = endAngle + (fullCircle * withGap)
            }
        }
    }
}

extension UIBezierPath {
    func cMove(x: Double, y: Double) {
        self.move(to: CGPoint(x: x, y: y))
    }
    
    func cAddLine(x: Double, y: Double) {
        self.addLine(to: CGPoint(x: x, y: y))
    }
    
    func cAddQuadCurve(toX: Double, toY: Double, cpX: Double, cpY: Double) {
        self.addQuadCurve(to: CGPoint(x: toX, y: toY), controlPoint: CGPoint(x: cpX, y: cpY))
    }
    
    func cAddCurve(toX: Double, toY: Double, cp1X: Double, cp1Y: Double, cp2X: Double, cp2Y: Double) {
        self.addCurve(to: CGPoint(x: toX, y: toY), controlPoint1: CGPoint(x: cp1X, y: cp1Y), controlPoint2: CGPoint(x: cp2X, y: cp2Y))
    }
}

extension CALayer {
    func addPath(path: UIBezierPath, lineWitdh: Double = 1, fillColor: CGColor = UIColor.clear.cgColor, strokeColor: CGColor = UIColor.black.cgColor) {
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = lineWitdh
        shape.fillColor = fillColor
        shape.strokeColor = strokeColor
        self.addSublayer(shape)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

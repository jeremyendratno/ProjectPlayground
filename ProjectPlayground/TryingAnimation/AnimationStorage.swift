//
//  AnimationStorage.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 5/20/22.
//

import Foundation
import UIKit

class AnimationStorage {
    static let sHeight = UIScreen.main.bounds.height
    static let sWidth = UIScreen.main.bounds.width
    static let shWidth = UIScreen.main.bounds.width / 2
    static let shHeight = UIScreen.main.bounds.height / 2
    
    static func bigThenSmall(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                view.transform = CGAffineTransform.identity
            }
        })
    }
    
    static func blink(view: UIView) {
        view.alpha = 0.2
        
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear], animations: {
            view.alpha = 1.0
        }, completion: nil)
    }
    
    static func pulse(view: UIView) {
        let pulseView = UIView()
        pulseView.backgroundColor = .systemBlue
        pulseView.frame.size.height = view.frame.size.height
        pulseView.frame.size.width = view.frame.size.height
        pulseView.frame.origin.x = view.frame.size.height / 4
        pulseView.layer.cornerRadius = pulseView.frame.size.height / 2
        pulseView.transform = CGAffineTransform(scaleX: 1, y: 1)
        pulseView.alpha = 0.1
        view.addSubview(pulseView)
        view.bringSubviewToFront(pulseView)
        
        UIView.animate(withDuration: 0.2, animations: {
            pulseView.transform = CGAffineTransform(scaleX: 3, y: 3)
        }, completion: { _ in
            pulseView.removeFromSuperview()
        })
    }
    
    static func hollowPulse(view: UIView) {
        let pulseView = UIView()
        pulseView.backgroundColor = .systemBlue
        pulseView.frame.size.height = view.frame.size.height
        pulseView.frame.size.width = view.frame.size.height
        pulseView.frame.origin.x = view.frame.size.height / 4
        pulseView.layer.cornerRadius = pulseView.frame.size.height / 2
        pulseView.alpha = 0.1
        
        let path = UIBezierPath(rect: pulseView.bounds)
        let size = CGSize(width: pulseView.frame.height / 2, height: pulseView.frame.width / 2)
        let rect = CGRect(origin: CGPoint(x: pulseView.frame.height / 4, y: pulseView.frame.width / 4), size: size)
        let circlePath = UIBezierPath(ovalIn: rect)
        path.append(circlePath)
        
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.red.cgColor
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        pulseView.layer.mask = maskLayer
        pulseView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        view.addSubview(pulseView)
        view.bringSubviewToFront(pulseView)
        
        UIView.animate(withDuration: 0.2, animations: {
            pulseView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            pulseView.removeFromSuperview()
        })
    }
    
    static func borderOut(view: UIView) {
        let border = UIView()
        let size = CGSize(width: view.frame.width + 4, height: view.frame.width + 4)
        let point = CGPoint(x: -2, y: -2)
        border.frame = CGRect(origin: point, size: size)
        border.backgroundColor = .blue
        border.layer.name = "Outer Border"
        border.layer.cornerRadius = border.frame.height / 2
        
        let path = UIBezierPath(rect: border.bounds)
        let pathSize = view.frame.size
        let pathPoint = CGPoint(x: 2, y: 2)
        let rect = CGRect(origin: pathPoint, size: pathSize)
        let circlePath = UIBezierPath(ovalIn: rect)
        path.append(circlePath)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        border.layer.mask = maskLayer
        
        view.addSubview(border)
        view.sendSubviewToBack(border)
    }
    
    static func removeBorderOut(view: UIView) {
        view.subviews.forEach {
            if $0.layer.name == "Outer Border" {
                $0.removeFromSuperview()
            }
        }
    }
    
    static func splashAnimation(hostView: UIView) {
        DispatchQueue.main.async { 
            let logo = UIView()
            let thePath = UIBezierPath()
            let sHeight = UIScreen.main.bounds.height
            let shWidth = UIScreen.main.bounds.width / 2
            let shHeight = UIScreen.main.bounds.height / 2
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .white
            backgroundView.frame = hostView.frame
            hostView.addSubview(backgroundView)
            hostView.bringSubviewToFront(backgroundView)
            
            logo.backgroundColor = .systemYellow
            logo.frame.size = CGSize(width: 100, height: 100)
            logo.circleCornerRadius()
            logo.frame.origin = CGPoint(x: -100, y: 0)
            backgroundView.addSubview(logo)
            
            let hollowView = UIView()
            hollowView.backgroundColor = .white
            hollowView.frame.size = CGSize(width: 55, height: 55)
            hollowView.frame.origin = CGPoint(x: logo.halfWidth() - 27.5, y: logo.halfHeight() - 27.5)
            hollowView.circleCornerRadius()
            logo.addSubview(hollowView)
            logo.bringSubviewToFront(hollowView)
            
            thePath.cMove(x: -100, y: shHeight)
            thePath.cAddQuadCurve(toX: shWidth, toY: sHeight - 84, cpX: shWidth / 2, cpY: 0)
            thePath.cAddQuadCurve(toX: shWidth, toY: shHeight, cpX: shWidth, cpY: 0)
            backgroundView.layer.addPath(path: thePath, lineWitdh: 2, strokeColor: UIColor.clear.cgColor)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                logo.frame.origin = CGPoint(x: shWidth - 50, y: shHeight - 50)
            }
            
            let theAnimation = CAKeyframeAnimation(keyPath: "position")
            theAnimation.path = thePath.cgPath
            theAnimation.calculationMode = .cubic
            theAnimation.duration = 1.5
            logo.layer.add(theAnimation, forKey: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                UIView.animate(withDuration: 0.5, animations: {
                    logo.transform = CGAffineTransform(scaleX: 20, y: 20)
                }) { _ in
                    logo.frame.origin = CGPoint(x: -100, y: 0)
                    logo.transform = CGAffineTransform(scaleX: 1, y: 1)
                    
                    UIView.animate(withDuration: 0.25, animations: {
                        backgroundView.alpha = 0
                    }) { _ in
                        backgroundView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    static func makeLogo(size: Double = 100) -> UIView {
        let logo = UIView()
        logo.backgroundColor = .systemYellow
        logo.frame.size = CGSize(width: size, height: size)
        logo.circleCornerRadius()
        logo.frame.origin = CGPoint(x: -100, y: 0)
        
        let hollowView = UIView()
        hollowView.backgroundColor = .white
        hollowView.frame.size = CGSize(width: size / 2, height: size / 2)
        hollowView.frame.origin = CGPoint(x: logo.halfWidth() - hollowView.halfWidth(), y: logo.halfHeight() - hollowView.halfHeight())
        hollowView.circleCornerRadius()
        logo.addSubview(hollowView)
        logo.bringSubviewToFront(hollowView)
        
        return logo
    }
    
    static func animationPathLayer(view: UIView, path: UIBezierPath, duration: Double = 1.0, isRepeat: Bool = false, keyTimes: [NSNumber] = []) {
        let theAnimation = CAKeyframeAnimation(keyPath: "position")
        theAnimation.calculationMode = .cubic
        theAnimation.duration = duration
        theAnimation.path = path.cgPath
        theAnimation.keyTimes = keyTimes
        
        if isRepeat {
            theAnimation.repeatCount = MAXFLOAT
        } else {
            theAnimation.repeatCount = 0
        }
        
        view.layer.add(theAnimation, forKey: nil)
    }
    
    static func splashAnimation2(hostView: UIView) {
        DispatchQueue.main.async {
            let logo = makeLogo()
            let logo2 = makeLogo()
            let logo3 = makeLogo()
            let logo4 = makeLogo()

            let sHeight = UIScreen.main.bounds.height
            let sWidth = UIScreen.main.bounds.width
            let shWidth = UIScreen.main.bounds.width / 2
            let shHeight = UIScreen.main.bounds.height / 2
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .white
            backgroundView.frame = hostView.frame
            hostView.addSubview(backgroundView)
            hostView.bringSubviewToFront(backgroundView)
             
            backgroundView.addSubview(logo)
            backgroundView.addSubview(logo2)
            backgroundView.addSubview(logo3)
            backgroundView.addSubview(logo4)
            
            let thePath = UIBezierPath()
            thePath.cMove(x: 0, y: 0)
            thePath.cAddQuadCurve(toX: shWidth, toY: shHeight, cpX: sWidth, cpY: 0)
            backgroundView.layer.addPath(path: thePath, lineWitdh: 2, strokeColor: UIColor.clear.cgColor)
            
            let thePath2 = UIBezierPath()
            thePath2.cMove(x: sWidth, y: 0)
            thePath2.cAddQuadCurve(toX: shWidth, toY: shHeight, cpX: sWidth, cpY: sHeight)
            backgroundView.layer.addPath(path: thePath2, lineWitdh: 2, strokeColor: UIColor.clear.cgColor)
            
            let thePath3 = UIBezierPath()
            thePath3.cMove(x: 0, y: sHeight)
            thePath3.cAddQuadCurve(toX: shWidth, toY: shHeight, cpX: 0, cpY: 0)
            backgroundView.layer.addPath(path: thePath3, lineWitdh: 2, strokeColor: UIColor.clear.cgColor)
            
            let thePath4 = UIBezierPath()
            thePath4.cMove(x: sWidth, y: sHeight)
            thePath4.cAddQuadCurve(toX: shWidth, toY: shHeight, cpX: 0, cpY: sHeight)
            backgroundView.layer.addPath(path: thePath4, lineWitdh: 2, strokeColor: UIColor.clear.cgColor)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                logo.frame.origin = CGPoint(x: shWidth - 50, y: shHeight - 50)
            }

            animationPathLayer(view: logo, path: thePath)
            animationPathLayer(view: logo2, path: thePath2)
            animationPathLayer(view: logo3, path: thePath3)
            animationPathLayer(view: logo4, path: thePath4)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                UIView.animate(withDuration: 0.5, animations: {
                    logo.transform = CGAffineTransform(scaleX: 20, y: 20)
                }) { _ in
                    logo.frame.origin = CGPoint(x: -100, y: 0)
                    logo.transform = CGAffineTransform(scaleX: 1, y: 1)

                    UIView.animate(withDuration: 0.25, animations: {
                        backgroundView.alpha = 0
                    }) { _ in
                        backgroundView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    static func loadingAnimation(hostView: UIView) {
        let logo = makeLogo(size: 20)
        let logo2 = makeLogo(size: 20)
        let logo3 = makeLogo(size: 20)
        let logo4 = makeLogo(size: 20)
        
        logo.frame.origin = CGPoint(x: shWidth, y: shHeight - 10)
        logo2.frame.origin = CGPoint(x: shWidth - 20, y: shHeight - 10)
        logo3.frame.origin = CGPoint(x: shWidth + 20, y: shHeight - 10)
        logo4.frame.origin = CGPoint(x: shWidth - 40, y: shHeight - 10)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.frame = hostView.frame
        hostView.addSubview(backgroundView)
        hostView.bringSubviewToFront(backgroundView)
         
        backgroundView.addSubview(logo)
        backgroundView.addSubview(logo2)
        backgroundView.addSubview(logo3)
        backgroundView.addSubview(logo4)
        
        let thePath3 = UIBezierPath()
        thePath3.cMove(x: shWidth + 30, y: shHeight)
        thePath3.cAddQuadCurve(toX: shWidth + 70, toY: shHeight - 40, cpX: shWidth + 60, cpY: shHeight - 10)
        thePath3.cAddQuadCurve(toX: shWidth + 30, toY: shHeight, cpX: shWidth + 60, cpY: shHeight - 10)
        backgroundView.layer.addPath(path: thePath3, lineWitdh: 2, strokeColor: UIColor.clear.cgColor)
        
        let thePath4 = UIBezierPath()
        thePath4.cMove(x: shWidth - 30, y: shHeight)
        thePath4.cAddQuadCurve(toX: shWidth - 70, toY: shHeight - 40, cpX: shWidth - 60, cpY: shHeight - 10)
        thePath4.cAddQuadCurve(toX: shWidth - 30, toY: shHeight, cpX: shWidth - 60, cpY: shHeight - 10)
        backgroundView.layer.addPath(path: thePath4, lineWitdh: 2, strokeColor: UIColor.clear.cgColor)
         
        playTheShit(logo3: logo3, path3: thePath3, logo4: logo4, path4: thePath4)
    }
    
    static func playTheShit(logo3: UIView, path3: UIBezierPath, logo4: UIView, path4: UIBezierPath) {
        let duration: Double = 1
        animationPathLayer(view: logo4, path: path4, duration: duration)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.animationPathLayer(view: logo3, path: path3, duration: duration)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.playTheShit(logo3: logo3, path3: path3, logo4: logo4, path4: path4)
            }
        }
    }
}

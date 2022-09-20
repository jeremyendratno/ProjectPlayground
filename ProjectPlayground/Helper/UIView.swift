//
//  UIView.swift
//  BrightStaffv2
//
//  Created by Jeremy Endratno on 6/27/22.
//

import Foundation
import UIKit

extension UIView {
    func cornerRadius(_ size: CGFloat) {
        self.layer.cornerRadius = size
    }
    
    func circleCornerRadius() {
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.height / 2 
        }
    }
    
    func basicShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.black.withAlphaComponent(5).cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height: 3)
    }
    
    func lessShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.black.withAlphaComponent(5).cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height: 2)
    }
    
    func isHiddenWithAnimation(isHidden: Bool) {
        if !isHidden {
            self.alpha = 0
            UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.isHidden = false
            }) { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 1
                })
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }) { _ in
                UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.isHidden = isHidden
                })
            }
        }
    }
    
    func showLoading(color: UIColor? = nil) {
        self.removeLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            let loading = UIActivityIndicatorView()
            
            if let color = color {
                loading.color = color
            }
            
            loading.layer.name = "Loading"
            loading.frame.origin = CGPoint(x: (self.frame.width / 2) - (loading.frame.width / 2), y: (self.frame.height / 2) - (loading.frame.height / 2))
            loading.startAnimating()
            self.addSubview(loading)
        }
    }
    
    func removeLoading() {
        DispatchQueue.main.async {
            self.subviews.forEach {
                if $0.layer.name == "Loading" {
                    $0.removeFromSuperview()
                }
            }
        }
    }
    
    func halfHeight() -> Double {
        return (frame.height / 2.0)
    }
    
    func halfWidth() -> Double {
        return (frame.width / 2.0)
    }
}

//
//  CustomTabbarViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 5/18/22.
//

import UIKit

class CustomTabbarViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabbarStackView: UIStackView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var mailImageView: UIImageView!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var scanImageView: UIImageView!
    @IBOutlet weak var scanLabel: UILabel!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var accountImageView: UIImageView!
    
    let homeViewController = ExampleOneViewController()
    let mailViewController = ExampleOneViewController()
    let addViewController = ExampleOneViewController()
    let scanViewController = ExampleOneViewController()
    let accountViewController = ExampleOneViewController()
    var isTabbarReady: Bool = true
    let stick = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    func viewSetup() {
        viewControllerSetup()
        tabBarSetup()
    }
    
    func viewControllerSetup() {
        DispatchQueue.main.async { [self] in
            homeViewController.view.frame.size = containerView.frame.size
            homeViewController.titleLabel.text = "Home"
            homeViewController.view.layer.name = "Home"
            
            mailViewController.view.frame.size = containerView.frame.size
            mailViewController.titleLabel.text = "Mail"
            mailViewController.view.layer.name = "Mail"
            
            addViewController.view.frame.size = containerView.frame.size
            addViewController.titleLabel.text = "Add"
            addViewController.view.layer.name = "Add"
            
            scanViewController.view.frame.size = containerView.frame.size
            scanViewController.titleLabel.text = "Scan"
            scanViewController.view.layer.name = "Scan"
            
            accountViewController.view.frame.size = containerView.frame.size
            accountViewController.titleLabel.text = "Account"
            accountViewController.view.layer.name = "Account"
            
            containerView.addSubview(homeViewController.view)
        }
    }
    
    func tabBarSetup() {
        let homeTap = UITapGestureRecognizer(target: self, action: #selector(didSelectHome))
        homeView.addGestureRecognizer(homeTap)
        
        let mailTap = UITapGestureRecognizer(target: self, action: #selector(didSelectMail))
        mailView.addGestureRecognizer(mailTap)
        
        let addTap = UITapGestureRecognizer(target: self, action: #selector(didSelectAdd))
        addView.addGestureRecognizer(addTap)
        addView.layer.cornerRadius = addView.frame.height / 2
        addView.layer.borderColor = UIColor.blue.cgColor
        tabBarMiddleViewSetup()
         
        let scanTap = UITapGestureRecognizer(target: self, action: #selector(didSelectScan))
        scanView.addGestureRecognizer(scanTap)
        
        let accountTap = UITapGestureRecognizer(target: self, action: #selector(didSelectAccount))
        accountView.addGestureRecognizer(accountTap)
        
        stackViewTopStick()
    }
    
    func tabBarMiddleViewSetup() {
        let path = UIBezierPath(rect: tabbarStackView.bounds)
        let size = CGSize(width: middleView.frame.width, height: middleView.frame.width)
        let point = CGPoint(x: (tabbarStackView.frame.width / 2) - (middleView.frame.width / 2), y: -(middleView.frame.width / 2))
        let rect = CGRect(origin: point, size: size)
        let circlePath = UIBezierPath(ovalIn: rect)
        path.append(circlePath)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        tabbarStackView.layer.mask = maskLayer
    }
    
    func stackViewTopStick() {
        stick.backgroundColor = .blue
        let size = CGSize(width: homeView.frame.width, height: 2)
        let point = CGPoint(x: 0, y: 0)
        stick.frame = CGRect(origin: point, size: size)
        tabbarStackView.addSubview(stick)
        tabbarStackView.bringSubviewToFront(stick)
    }
    
    func active(view: UIView, imageView: UIImageView, label: UILabel) {
        imageView.tintColor = .systemBlue
        label.textColor = .systemBlue
        isTabbarReady = false
        
        if view == addView {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.stick.frame.origin = CGPoint(x: (self.tabbarStackView.frame.width / 2) - (self.stick.frame.width / 2), y: 0)
            }, completion: { _ in
                if self.addView.layer.name != "With Border" {
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                        AnimationStorage.borderOut(view: view)
                        self.addView.layer.name = "With Border"
                    }, completion: { _ in
                        self.isTabbarReady = true
                    })
                } else {
                    self.isTabbarReady = true
                }
            })
        } else {
            if addView.layer.name == "With Border" {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                    AnimationStorage.removeBorderOut(view: self.addView)
                    self.addView.layer.name = "No Border"
                }, completion: { _ in
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                        self.stick.frame.origin = CGPoint(x: view.frame.origin.x, y: 0)
                    }, completion: { _ in
                        self.isTabbarReady = true
                    })
                })
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                    self.stick.frame.origin = CGPoint(x: view.frame.origin.x, y: 0)
                }, completion: { _ in
                    self.isTabbarReady = true
                })
            }
        }
    }
    
    func deactive(imageView: UIImageView, label: UILabel) {
        imageView.tintColor = .lightGray
        label.textColor = .lightGray
    }
    
    func deactiveAll() {
        deactive(imageView: homeImageView, label: homeLabel)
        deactive(imageView: mailImageView, label: mailLabel)
        deactive(imageView: addImageView, label: addLabel)
        deactive(imageView: scanImageView, label: scanLabel)
        deactive(imageView: accountImageView, label: accountLabel)
        
        containerView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    @objc func didSelectHome() {
        if !isTabbarReady { return }
        
        deactiveAll()
        active(view: homeView, imageView: homeImageView, label: homeLabel)
        containerView.addSubview(homeViewController.view)
    }
    
    @objc func didSelectMail() {
        if !isTabbarReady { return }
        
        deactiveAll()
        active(view: mailView, imageView: mailImageView, label: mailLabel)
        containerView.addSubview(mailViewController.view)
    }
    
    @objc func didSelectAdd() {
        if !isTabbarReady { return }
        
        deactiveAll()
        active(view: addView, imageView: addImageView, label: addLabel)
        containerView.addSubview(addViewController.view)
    }
    
    @objc func didSelectScan() {
        if !isTabbarReady { return }
        
        deactiveAll()
        active(view: scanView, imageView: scanImageView, label: scanLabel)
        containerView.addSubview(scanViewController.view)
    }
    
    @objc func didSelectAccount() {
        if !isTabbarReady { return }
        
        deactiveAll()
        active(view: accountView, imageView: accountImageView, label: accountLabel)
        containerView.addSubview(accountViewController.view)
    }
}

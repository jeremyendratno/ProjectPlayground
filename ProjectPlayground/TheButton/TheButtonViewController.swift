//
//  TheButtonViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 9/7/22.
//

import UIKit

class TheButtonViewController: UIViewController {
    @IBOutlet weak var theButtonBack: UIView!
    @IBOutlet weak var theButton: UIView!
    @IBOutlet weak var theButtonBottom: NSLayoutConstraint!
    @IBOutlet weak var theButtonRight: NSLayoutConstraint!
    @IBOutlet weak var theButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var theButtonTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theButton.cornerRadius(10)
        theButtonBack.cornerRadius(10)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pressed))
        theButtonBack.addGestureRecognizer(tap)
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longTap.minimumPressDuration = 0.1
        theButtonBack.addGestureRecognizer(longTap)
    }
    
    @objc func pressed() {
        UIView.animate(withDuration: 0.1, animations: {
            self.theButtonBottom.constant = 0
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.theButtonBottom.constant = 7.5
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            UIView.animate(withDuration: 0.1, animations: {
                self.theButtonBottom.constant = 0
                self.view.layoutIfNeeded()
            })
        } else if sender.state == .ended || sender.state == .cancelled {
            UIView.animate(withDuration: 0.1, animations: {
                self.theButtonBottom.constant = 7.5
                self.view.layoutIfNeeded()
            })
        }
    }
}

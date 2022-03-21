//
//  MovingViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 1/7/22.
//

import UIKit

class MovingViewController: UIViewController {
    @IBOutlet weak var theView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func theButton(_ sender: Any) {
        self.theView.frame.origin.y += 200
    }
    
}

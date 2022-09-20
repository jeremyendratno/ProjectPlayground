//
//  TryingAnimationViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 7/1/22.
//

import UIKit

class TryingAnimationViewController: UIViewController {
    let logo = UIView()
    let thePath = UIBezierPath()
    
    let sWidth = UIScreen.main.bounds.width
    let sHeight = UIScreen.main.bounds.height
    
    let shWidth = UIScreen.main.bounds.width / 2
    let shHeight = UIScreen.main.bounds.height / 2
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func playButton(_ sender: Any) {
        AnimationStorage.loadingAnimation(hostView: view)
    }
}

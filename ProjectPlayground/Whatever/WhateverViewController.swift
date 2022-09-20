//
//  WhateverViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 4/6/22.
//

import UIKit

class WhateverViewController: UIViewController {
    let other = Whatever2ViewController()
    
    @IBOutlet weak var someTextField: SomeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func someButton(_ sender: Any) {
        self.present(other, animated: true)
    }
}

class SomeTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("override")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("required")
    }
}

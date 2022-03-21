//
//  ViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 12/22/21.
//

import UIKit

class ViewController: UIViewController {
    let firstThread = DispatchQueue(label: "first")
    let secondThread = DispatchQueue(label: "second")
    let loadSemaphore = DispatchSemaphore(value: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondThread.asyncAfter(deadline: .now() + 3) {
            print("First queue is done!")
            self.loadSemaphore.signal()
        }
        
        print("uuuuu")

        firstThread.async {
            self.loadSemaphore.wait()
            print("wo!")
            print("wi!")
        }
        
        print("iiiii")
    }
}

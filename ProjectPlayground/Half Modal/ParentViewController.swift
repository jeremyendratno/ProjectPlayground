//
//  ParentViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 1/8/22.
//

import UIKit

class ParentViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func button(_ sender: Any) {
        let childVC = ChildViewController()
        childVC.view.backgroundColor = .red
        childVC.modalPresentationStyle = .popover
        let popOver: UIPopoverPresentationController = childVC.popoverPresentationController!
        popOver.delegate = self
//        childVC.transitioningDelegate = self
        popOver.sourceView = button
        present(childVC, animated: true)
    }
}

extension ParentViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
        
    }
}

//extension ParentViewController: UIViewControllerTransitioningDelegate {
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//            return HalfSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
//        }
//}

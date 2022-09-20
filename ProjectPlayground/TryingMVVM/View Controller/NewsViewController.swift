//
//  NewsViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 6/23/22.
//

import Foundation
import UIKit

class NewsViewController: UIViewController, NewsDelegate {
    let viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.requestNewsList()
    }
     
    func onRequestNewsListSuccess() {
        print(viewModel.news)
        print(viewModel.getDisplayNewsData(index: 0))
    }
    
    func onRequestNewsListFailed(message: String) {
        print(message)
    }
}

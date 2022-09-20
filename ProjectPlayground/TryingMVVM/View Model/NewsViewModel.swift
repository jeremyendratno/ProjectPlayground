//
//  NewsViewModel.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 6/23/22.
//

import Foundation

protocol NewsDelegate: AnyObject {
    func onRequestNewsListSuccess()
    func onRequestNewsListFailed(message: String)
}

struct NewsListDisplay {
    var title: String
    var description: String
    var date: String
}

class NewsViewModel {
    weak var delegate: NewsDelegate?
    var news: [News] = []
    
    func requestNewsList() {  
        NewsService.requestNewsList { result in
            switch result {
            case .success(let news):
                self.news.append(contentsOf: news)
                
                DispatchQueue.main.async {
                    self.delegate?.onRequestNewsListSuccess()
                }
            case .failure(_, let message):
                DispatchQueue.main.async {
                    self.delegate?.onRequestNewsListFailed(message: message)
                }
            }
        }
    }
    
    func getDisplayNewsData(index: Int) -> NewsListDisplay {
        var value = NewsListDisplay(title: "No title was found", description: "No description was found", date: "No date was found")
        
        if news.count > index {
            if let title = news[index].title?.value {
                value.title = title
            }
            
            if let description = news[index].content?.value {
                value.description = description
            }
            
            if let date = news[index].content?.value.displayDateFormat() {
                value.date = date
            }
        }
        
        return value
    }
}

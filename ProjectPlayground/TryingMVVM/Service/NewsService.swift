//
//  NewsService.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 6/23/22.
//

import Foundation
import Alamofire

class NewsService: BaseService {
    static func requestNewsList(parameter: NSMutableDictionary = [:], completionHandler: @escaping (RequestResult<[News]>) -> Void) {
        guard let url = URL(string: URLStorage.News.search) else {
            completionHandler(.failure(.urlNotFound))
            print("Request failed, URL found nil")
            return
        }
        
        parameter.addEntries(from: ParameterStorage.getClientId())
        
        guard let parameter = parameter as? Parameters else {
            completionHandler(.failure(.parameterNotFound))
            print("Request failed, parameter can't be converted")
            return
        }
        
        request(response: [News].self, url: url, method: .get, parameter: parameter) { response in
            completionHandler(response)
        }
    }
}

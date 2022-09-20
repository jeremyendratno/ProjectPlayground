//
//  BaseService.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 6/23/22.
//

import Foundation
import Alamofire

enum RequestFailure {
    case errorOccured
    case responseDataNil
    case dataNil
    case non200Code
    case failedToDecode
    case urlNotFound
    case parameterNotFound
}

enum RequestResult<T> {
    case success(T)
    case failure(RequestFailure, message: String = "No Message")
}

class BaseService {
    static func request<T: Codable>(response: T.Type, url: URL, method: HTTPMethod = .get, parameter: Parameters = [:], completionHandler: @escaping (RequestResult<T>) -> Void) {
        AF.request(url, method: method, parameters: parameter).validate().response() { response in
            if let error = response.error {
                completionHandler(.failure(.errorOccured))
                print("Request failed, error occurred: \(error.localizedDescription)")
                return
            }
            
            guard let data = response.data else {
                completionHandler(.failure(.responseDataNil))
                print("Request failed, response data found nil")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Response<T>.self, from: data)
                
                if decodedData.message?.code?.value == "200" {
                    if let data = decodedData.data {
                        completionHandler(.success(data))
                        print("Request success")
                    } else {
                        completionHandler(.failure(.dataNil, message: decodedData.message?.text?.value ?? ""))
                        print("Request failed, receive non 200 code")
                    }
                } else {
                    completionHandler(.failure(.non200Code, message: decodedData.message?.text?.value ?? ""))
                    print("Request failed, data found nil")
                }
            } catch {
                completionHandler(.failure(.failedToDecode))
                print("Request failed, failed to decode")
            }
        }
    }
}

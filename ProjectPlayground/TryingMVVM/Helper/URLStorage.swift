//
//  URLStrorage.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 6/23/22.
//

import Foundation

class URLStorage {
    private static let baseURL = "https://www.brighton.co.id"
    
    struct News {
        private static let baseNewsURL = baseURL + "/news-api/"
        
        static let search = baseNewsURL + "search/"
        static let view = baseNewsURL + "view/"
    }
}

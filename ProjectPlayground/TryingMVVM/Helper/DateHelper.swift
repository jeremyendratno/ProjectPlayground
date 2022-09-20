//
//  DateFormatter.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 6/23/22.
//

import Foundation

extension String {
    func displayDateFormat() -> String? {
        let defaultDateFormatter = DateFormatter()
        defaultDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = defaultDateFormatter.date(from: self)
        
        let readableDateFormatter = DateFormatter()
        readableDateFormatter.dateFormat = "dd MMM yyyy"
        
        if let date = date {
            return readableDateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}

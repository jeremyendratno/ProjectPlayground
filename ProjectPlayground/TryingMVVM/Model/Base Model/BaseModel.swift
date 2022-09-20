//
//  BaseModel.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 6/23/22.
//

import Foundation

struct StringResponse: Codable {
    var value: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let val = try? container.decode(String.self) {
            value = val
        } else if let val = try? container.decode(Int.self) {
            value = "\(val)"
        } else if let val = try? container.decode(Double.self) {
            value = "\(val)"
        } else if let val = try? container.decode(Float.self) {
            value = "\(val)"
        } else if let val = try? container.decode(Bool.self) {
            if val {
                value = "1"
            } else {
                value = "0"
            }
        } else {
            value = ""
        }
    }
}

struct Message: Codable {
    var code: StringResponse?
    var text: StringResponse?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case text = "Text"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decodeIfPresent(StringResponse.self, forKey: .code)
        text = try container.decodeIfPresent(StringResponse.self, forKey: .text)
    }
}

struct Response<T: Codable>: Codable {
    var message: Message?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case data = "Data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decodeIfPresent(Message.self, forKey: .message)
        data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}



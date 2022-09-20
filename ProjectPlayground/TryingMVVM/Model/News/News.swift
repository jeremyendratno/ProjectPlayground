//
//  News.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 6/23/22.
//

import Foundation

struct News: Codable {
    var id: StringResponse?
    var created: StringResponse?
    var title: StringResponse?
    var author: StringResponse?
    var content: StringResponse?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case created = "Created"
        case title = "Title"
        case author = "Author"
        case content = "Content"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(StringResponse.self, forKey: .id)
        created = try container.decodeIfPresent(StringResponse.self, forKey: .created)
        title = try container.decodeIfPresent(StringResponse.self, forKey: .title)
        author = try container.decodeIfPresent(StringResponse.self, forKey: .author)
        content = try container.decodeIfPresent(StringResponse.self, forKey: .content)
    }
}

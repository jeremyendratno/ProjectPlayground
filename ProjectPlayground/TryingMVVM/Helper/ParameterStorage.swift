//
//  ParameterStorage.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 6/23/22.
//

import Foundation

class ParameterStorage {
    private static let clientId = ["ClientID": "f9dabd9ada9e1f333c2e4f17380f7620"]
    
    static func getClientId() -> [String: Any] {
        return clientId
    }
}

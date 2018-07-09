//
//  Common.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]
typealias HeadersDict = [String: String]

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

struct APIResourceName: RawRepresentable {
    var rawValue: String
}

enum URLQueryEncoder {
    
    static func encode<T: Encodable>(_ encodable: T)  -> String {
        let parametersData = try? JSONEncoder().encode(encodable)
        
        let parameters = parametersData?.jsonDictionary ?? [:]
        
        return parameters
            .map({ "\($0)=\($1)" })
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}

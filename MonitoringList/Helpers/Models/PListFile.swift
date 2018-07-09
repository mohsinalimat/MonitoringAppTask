//
//  PListFile.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

class PListFile<Value: Codable> {
    
    enum Errors: Error {
        case fileNotFound
    }
    
    enum Source {
        case infoPlist
        case plist(String)
        
        func data() throws -> Data {
            switch self {
            case .infoPlist:
                guard let infoDict = Bundle.main.infoDictionary else {
                    throw Errors.fileNotFound
                }
                return try JSONSerialization.data(withJSONObject: infoDict)
            case .plist(let filename):
                guard let path = Bundle.main.path(forResource: filename, ofType: "plist") else {
                    throw Errors.fileNotFound
                }
                let dictionary = NSDictionary(contentsOfFile: path) ?? [:]
                return try JSONSerialization.data(withJSONObject: dictionary)
            }
        }
    }
    
    let data: Value
    
    init(_ file: PListFile.Source = .infoPlist) throws {
        let rawData = try file.data()
        let decoder = JSONDecoder()
        self.data = try decoder.decode(Value.self, from: rawData)
    }
    
}

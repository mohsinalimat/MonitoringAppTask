//
//  ServerConfigPlist.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

struct ServerConfiguration: Codable {
    
    enum CodingKeys: String, CodingKey {
        case configuration = "Server Configuration"
    }
    
    let configuration: Configuration
    
}

extension ServerConfiguration {
    
    struct Configuration: Codable {
        let baseURL: String?
    }
}



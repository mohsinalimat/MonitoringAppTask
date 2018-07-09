//
//  ServiceConfigurator.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

class ServiceConfigurator {
    
    private(set) var url: URL
    
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    var timeout: TimeInterval = 15.0
    
    init(baseURL: String) {
        guard let url = URL(string: baseURL) else {
            fatalError("baseURL could not be configured.")
        }
        self.url = url
    }
    
    convenience init() {
        
        do {
            let pList = try PListFile<ServerConfiguration>()
            let url = pList.data.configuration.baseURL ?? ""
            self.init(baseURL: url)
        } catch let error {
            fatalError("Failed to parse data: \(error)")
        }
        
    }
    
}

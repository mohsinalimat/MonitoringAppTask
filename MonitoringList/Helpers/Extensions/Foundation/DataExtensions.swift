//
//  DataExtensions.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

extension Data {
    
    var jsonDictionary: JSONDictionary {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            return jsonObject as? JSONDictionary ?? [:]
        } catch {
            return [:]
        }
    }
}

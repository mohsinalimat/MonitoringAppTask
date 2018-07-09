//
//  DictionaryExtensions.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any  {
    
    var jsonString: String {
        guard JSONSerialization.isValidJSONObject(self) else {
            return ""
        }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
            return ""
        }
        return String(bytes: jsonData, encoding: .utf8) ?? ""
    }
    
}

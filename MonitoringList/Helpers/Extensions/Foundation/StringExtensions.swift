//
//  StringExtensions.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/8/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

extension String {
    
    var isBlank: Bool {
        let trimmed = trimmingCharacters(in: .whitespaces)
        return trimmed.isEmpty
    }
    
}

//
//  TableState.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/8/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

enum TableState<Value> {
    
    case loading
    case paging([Value], next: Int)
    case populated([Value])
    case filtered([Value])
    case error(String)
    
    var items: [Value] {
        switch self {
        case .paging(let items, _):
            return items
        case .populated(let items):
            return items
        case .filtered(let items):
            return items
        default:
            return []
        }
    }
}


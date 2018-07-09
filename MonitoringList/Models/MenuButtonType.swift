//
//  MenuButtonType.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/8/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

enum MenuButtonType {
    case connect
    case menu
    case global
    
    var imageName: ImageName {
        switch self {
        case .connect: return .connect
        case .menu: return .menu
        case .global: return .global
        }
    }
}

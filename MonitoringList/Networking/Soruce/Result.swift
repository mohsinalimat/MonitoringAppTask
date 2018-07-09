//
//  Result.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(String)
}

typealias ResultHandler<Value> = (Result<Value>) -> Void

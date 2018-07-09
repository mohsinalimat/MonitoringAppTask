//
//  MachineRequest.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

struct MachineRequest: APIRequest {
    
    typealias Response = MachineResponse

    let page: Int
    
    let size: Int
    
    var method: RequestMethod {
        return .get
    }
    
    var resourceName: APIResourceName {
        return .machine
    }
    
}

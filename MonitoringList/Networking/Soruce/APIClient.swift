//
//  APIClient.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

protocol APIClient {
    
    var configuration: ServiceConfigurator { get }
    
    init(_ configuration: ServiceConfigurator)
    
    func execute<T: APIRequest>(_ request: T, completion: @escaping ResultHandler<T.Response>)
}

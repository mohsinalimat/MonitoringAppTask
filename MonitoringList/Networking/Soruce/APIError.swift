//
//  APIError.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

struct APIError: Decodable {
    let status: Int?
    let exception: String?
    let message: String?
    let timestamp: Int?
    let path: String?
    let error: String?
}

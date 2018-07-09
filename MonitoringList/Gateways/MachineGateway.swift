//
//  MachineGateway.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

protocol MachineGateway {
    func fetchMachines(_ request: MachineRequest, completion: @escaping ResultHandler<MachineModel>)
}

class APIMachineGateway: MachineGateway {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchMachines(_ request: MachineRequest, completion: @escaping (Result<MachineModel>) -> Void) {
        apiClient.execute(request) { (result: Result<MachineResponse>) in
            switch result {
            case .success(let value):
                completion(.success(value.asViewModel()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//
//  MachineResponse.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

struct MachineResponse: Decodable {
    
    struct Status: Decodable {
        let id: Int?
        let statusValue: String?
    }
    
    struct Model: Decodable {
        let name: String?
    }
    
    struct Content: Decodable {
        let ipSubnetMask: String?
        let status: Status?
        let id: Int?
        let ipAddress: String?
        let name: String?
        let model: Model?
    }
    
    let content: [Content]?
    let number: Int?
    let totalPages: Int?
}

extension MachineResponse: ModelConvertible {
    func asViewModel() -> MachineModel {
        return MachineModel(
            viewModels: content?.map({ $0.asViewModel() }) ?? [],
            page: MachineModel.Page(
                numberOfPages: totalPages ?? 0,
                currentPage: number ?? 0
            )
        )
    }
}
extension MachineResponse.Content: ModelConvertible {
    
    func asViewModel() -> MachineModel.ViewModel {
        return MachineModel.ViewModel(
            country: name ?? "-",
            model: model?.name ?? "-",
            ipAddress: ipAddress ?? "-",
            macAddress: ipSubnetMask ?? "-",
            status: MachineModel.ViewModel.Status(
                id: status?.id ?? 999,
                message: status?.statusValue ?? "-"
            )
        )
    }
}


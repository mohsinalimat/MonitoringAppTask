//
//  MachineModel.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

class MachineModel {
    
    private(set) var viewModels: [ViewModel]
    private(set) var page: Page
    
    init(viewModels: [ViewModel], page: Page) {
        self.viewModels = viewModels
        self.page = page
    }
    
}

//MARK: - ViewModel
extension MachineModel {
    struct ViewModel {
        struct Status {
            private(set) var id: Int
            private(set) var message: String
            
            var color: Color {
                switch id {
                case 1: return .green
                case 2: return .orange
                case 3: return .yellow
                case 4: return .red
                default: return .white
                }
            }
        }
        
        private(set) var country: String
        private(set) var model: String
        private(set) var ipAddress: String
        private(set) var macAddress: String
        private(set) var status: Status
        private(set) var options: [MachineOptionViewModel]
        
        init(country: String,
             model: String,
             ipAddress: String,
             macAddress: String,
             status: Status) {
            
            self.country = country
            self.model = model
            self.ipAddress = ipAddress
            self.macAddress = macAddress
            self.status = status
            self.options = [
                MachineOptionViewModel(type: .checkmark),
                MachineOptionViewModel(type: .call),
                MachineOptionViewModel(type: .timer),
                MachineOptionViewModel(type: .sound)
            ]
        }
    }
}

//MARK: - Pagination
extension MachineModel {
    struct Page {
        private(set) var numberOfPages: Int
        private(set) var currentPage: Int
        
        var hasMorePages: Bool {
            return currentPage < numberOfPages
        }
        
        var nextPage: Int {
            return hasMorePages ? currentPage + 1 : currentPage
        }
    }
}

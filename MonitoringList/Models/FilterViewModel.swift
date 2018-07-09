//
//  FilterViewModel.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/8/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation


class FilterViewModel {
    
    enum ButtonType {
        case all
        case active
        case down
        case allLocations
    }
    
    private(set) var title: String
    private(set) var type: ButtonType
    var isSelected: Bool
    
    init(title: String,
         type: ButtonType,
         isSelected: Bool = false) {
        
        self.title = title
        self.type = type
        self.isSelected = isSelected
    }
    
    var backgroundColor: Color {
        return isSelected ? .filterButtonBG: .white
    }
    
    var titleColor: Color {
        return isSelected ? .white: .lightGray
    }
}

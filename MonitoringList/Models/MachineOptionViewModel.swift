//
//  MachineOptionViewModel.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

class MachineOptionViewModel {
    
    enum OptionType {
        
        case checkmark
        case call
        case timer
        case sound
        
        var selectedColor: Color {
            switch self {
            case .call: return .pink
            case .checkmark: return .purple
            case .timer: return .blue
            case .sound: return .red
            }
        }

    }
    
    private(set) var type: OptionType
    var isSelected: Bool
    
    var backgroundColor: Color {
        return isSelected ? type.selectedColor: Color.darkGray
    }
    
    init(type: OptionType) {
        self.type = type
        self.isSelected = false
    }
}


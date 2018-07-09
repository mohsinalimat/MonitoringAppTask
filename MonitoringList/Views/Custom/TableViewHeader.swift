//
//  TableViewHeader.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {
    
    //MARK: Outlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
}

//MARK: - Presentation
extension TableViewHeader {
    func display(backgroundColor: Color) {
        containerView.backgroundColor = backgroundColor.rawValue
    }
    
    func display(title: String) {
        titleLabel.text = title
    }
}

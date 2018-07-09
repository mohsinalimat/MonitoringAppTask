//
//  EmptyStateView.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/8/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    //MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
}

//MARK: - Presentaion
extension EmptyStateView {
    func display(message: String) {
        titleLabel.text = message
    }
}

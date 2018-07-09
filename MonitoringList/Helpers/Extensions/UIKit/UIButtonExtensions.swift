//
//  UIButtonExtensions.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

extension UIButton {
    
    func indexPath(_ tableView: UITableView) -> IndexPath? {
        let origin = frame.origin
        guard let point = superview?.convert(origin, to: tableView) else { return nil }
        return tableView.indexPathForRow(at: point)
    }
    
}

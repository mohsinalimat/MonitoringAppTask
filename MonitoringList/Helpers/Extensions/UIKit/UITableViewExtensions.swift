//
//  UITableViewExtensions.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        let nib  = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Error dequeuing cell for identifier \(T.identifier)")
        }
        return cell
    }
    
}

extension UITableView {
    
    func register<T: UITableViewHeaderFooterView>(headerFooterView type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: T.identifier)
        
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
            fatalError("Error dequeuing headerFooterView")
        }
        return headerFooterView
    }
    
}

extension UITableView {
    
    func setupFooterHeight() {
        estimatedSectionFooterHeight = sectionFooterHeight
        sectionFooterHeight = UITableViewAutomaticDimension
    }
    
    func setupHeaderHeight() {
        estimatedSectionHeaderHeight = sectionHeaderHeight
        sectionHeaderHeight = UITableViewAutomaticDimension
    }
    
}

extension UITableView {
    func setFooterView<T>(forState state: TableState<T>) {
        switch state {
        case .error(let message):
            let emptyView = EmptyStateView.instantiateFromNib()
            emptyView?.display(message: message)
            tableFooterView = emptyView
        case .loading:
            let loadingView = LoadingView.instantiateFromNib()
            loadingView?.updateActivityIndicator(color: .darkGray)
            tableFooterView = loadingView
        case .paging:
            let loadingView = LoadingView.instantiateFromNib()
            loadingView?.updateActivityIndicator(color: .darkGray)
            tableFooterView = loadingView
        case .populated:
            tableFooterView = nil
        case .filtered:
            tableFooterView = nil 
        }
    }
}

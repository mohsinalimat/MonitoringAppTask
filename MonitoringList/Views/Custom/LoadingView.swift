//
//  LoadingView.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/8/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    //MARK: Outlets
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
}

//MARK: - Presentation
extension LoadingView {
    func updateActivityIndicator(color: Color) {
        activityIndicatorView.color = color.rawValue
    }
}

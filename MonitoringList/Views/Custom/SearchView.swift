//
//  SearchView.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/8/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    enum ActionType {
        case search
        case cancel
    }
    
    //MARK: Outlets
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    //MARK: CallBack
    var textHandler: ((String) -> Void)?
    var actionHandler: ((ActionType, UISearchBar) -> Void)?
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: Setup
    private func setup() {
        loadFromNib()
    }
}

//MARK: - Public
extension SearchView {
    func display(placeholder: String) {
        searchBar.placeholder = placeholder
    }
    
    func displayBar(color: Color) {
        searchBar.tintColor = color.rawValue
        searchBar.barTintColor = color.rawValue
    }
    
    func setAutocapitalizationType(_ type: UITextAutocapitalizationType) {
        searchBar.autocapitalizationType = type
    }
    
    func setAutocorrectionType(_ type: UITextAutocorrectionType) {
        searchBar.autocorrectionType = type
    }
    
    func setSearchBarEnabled(_ enabled: Bool) {
        searchBar.isUserInteractionEnabled = enabled
    }
}

//MARK: - UISearchBarDelegate
extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textHandler?(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        actionHandler?(.search, searchBar)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        actionHandler?(.cancel, searchBar)
    }
}

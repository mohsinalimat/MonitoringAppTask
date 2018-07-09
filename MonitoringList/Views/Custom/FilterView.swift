//
//  FilterView.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/8/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    //MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var buttons: [UIButton]!
    
    private var items: [FilterViewModel] = [] {
        didSet {
            updateButtons()
        }
    }
    
    //MARK: Callback
    var handler: ((FilterViewModel.ButtonType) -> Void)?
    
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
    
    //MARK: Actions
    @IBAction private func buttonTapped(_ sender: UIButton) {
        guard let index = buttons.index(of: sender) else { return }
        items.forEach({ $0.isSelected = false })
        let item = items[index]
        item.isSelected = true
        updateButtons()
        handler?(item.type)
    }
}

//MARK: Private Methods
private extension FilterView {
    
    func updateButtons() {
        buttons.enumerated().forEach({
            let item = items[$0.offset]
            $0.element.setTitle(item.title, for: .normal)
            $0.element.setTitleColor(item.titleColor.rawValue, for: .normal)
            $0.element.backgroundColor = item.backgroundColor.rawValue
        })
    }
}

//MARK: Helpers
extension FilterView {
    
    func displayFitler(title: String) {
        titleLabel.text = title 
    }
    
    func displayFitlerItems(_ items: [FilterViewModel]) {
        self.items = items
        
    }
}

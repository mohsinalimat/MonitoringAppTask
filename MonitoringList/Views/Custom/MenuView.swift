//
//  MenuView.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/8/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    //MARK: Outlets
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private var buttons: [UIButton]!
    
    private var items: [MenuButtonType] = [] {
        didSet {
            buttons.enumerated().forEach({
                let item = items[$0.offset]
                let image = UIImage(named: item.imageName.rawValue)
                $0.element.setImage(image, for: .normal)
            })
        }
    }
    
    //MARK: Callback
    var handler: ((MenuButtonType) -> Void)?
    
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
        handler?(items[index])
    }
}

extension MenuView {
    
    func display(counter: String) {
        counterLabel.text = counter
    }
    
    func display(items: [MenuButtonType]) {
        self.items = items
    }
}

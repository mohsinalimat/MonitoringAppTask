//
//  MachineCell.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

typealias ButtonsHandler = (UIButton, Int) -> Void

class MachineCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var machineImageView: UIImageView! 
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var modelLabel: UILabel!
    @IBOutlet private weak var ipAddressLabel: UILabel!
    @IBOutlet private weak var macAddressLabel: UILabel!
    @IBOutlet private var buttons: [UIButton]!
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var statusDescriptionView: UIView!
    @IBOutlet private weak var statusLabel: UILabel!
    
    private var optionItems: [MachineOptionViewModel] = [] {
        didSet {
            buttons.enumerated().forEach({
                let item = optionItems[$0.offset]
                $0.element.backgroundColor = item.backgroundColor.rawValue
            })
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        displayContainer(backgroundColor: selected ? .lightBlue: .white)
    }
    
    //MARK: CallBack
    var optionHandler: ButtonsHandler?
    
    //MARK: Actions
    @IBAction private func buttonTapped(_ sender: UIButton) {
        guard let index = buttons.index(of: sender) else { return }
        optionHandler?(sender, index)
    }

}

//MARK: - Presentation
extension MachineCell {
    
    func update(selectionStyle: UITableViewCellSelectionStyle) {
        self.selectionStyle = selectionStyle
    }
    
    func display(backgroundColor: Color) {
        self.backgroundColor = backgroundColor.rawValue
    }
    
    func displayContainer(backgroundColor: Color) {
        containerView.backgroundColor = backgroundColor.rawValue
    }
    
    func displayImage(name: ImageName, circleCorner: Bool = true) {
        machineImageView.image = UIImage(named: name.rawValue)
        machineImageView.circleCorner = circleCorner
        machineImageView.maskToBounds = true
    }
    
    func display(country: String) {
        countryLabel.text = country
    }
    
    func display(model: String) {
        modelLabel.text = model
    }
    
    func display(ipAddress: String) {
        ipAddressLabel.text = ipAddress
    }
    
    func display(macAddress: String) {
        macAddressLabel.text = macAddress
    }
    
    func updateOption(items: [MachineOptionViewModel]) {
        optionItems = items
    }
    
    func setOptionButtonCircleCornerEnabled(_ enabled: Bool = true) {
        buttons.forEach({
            $0.circleCorner = enabled
        })
    }
    
    func setStatusCircleCornerEnabled(_ enabled: Bool = true) {
        statusView.circleCorner = enabled
    }
    
    func displayStatusCircle(color: Color) {
        statusView.backgroundColor = color.rawValue
    }
    
    func displayStatusMessage(message: String, color: Color) {
        statusLabel.text = message
        statusDescriptionView.backgroundColor = color.rawValue
    }
    
    func setStatusMessageHidden(_ isHidden: Bool) {
        statusDescriptionView.isHidden = isHidden
    }
}











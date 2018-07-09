//
//  DashboardBarView.swift
//  
//
//  Created by Anas Alhasani on 7/8/18.
//

import UIKit

class DashboardBarView: UIView {
    
    //MARK: Outlets
    @IBOutlet private weak var logoView: UIView!
    @IBOutlet private weak var profileButton: UIButton!
    
    //MARK: Callback
    var handler: (() -> Void)?
    
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
    @IBAction private func profileButtonTapped(_ sender: UIButton) {
        handler?()
    }
}

//MARK: Presentation
extension DashboardBarView {
    
    func displayLogoImage(name: ImageName, cornerRadius: CGFloat) {
        //logoImageView.image = UIImage(named: name.rawValue)
        logoView.cornerRadius = cornerRadius
    }
    
    func displayUserImage(name: ImageName, circleCorner: Bool) {
        let image = UIImage(named: name.rawValue)
        profileButton.setImage(image, for: .normal)
        profileButton.circleCorner = circleCorner
        profileButton.maskToBounds = true 
    }
    
    func displayBarBackground(color: Color) {
        backgroundColor = color.rawValue
    }
}

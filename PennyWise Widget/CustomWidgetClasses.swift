//
//  CustomClasses.swift
//  PennyWiseWidget
//
//  Created by Ghulam Hasnain on 06/03/2019.
//  Copyright © 2019 Ghulam Hasnain. All rights reserved.
//

import UIKit

class customWidgetButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set border
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        
        // Set color of title
        self.setTitleColor(UIColor.black, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}

class CustomWidgetCollectionViewCell: UICollectionViewCell {
    
    var accountLabel: UILabel! = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = UIColor.black
        return view
    }()
    
    var amountLabel: UILabel! = {
        let view = UILabel()
        view.textColor = UIColor.black
        view.textAlignment = .center
        return view
    }()
    
    var leftButton: UIButton! = {
        let view = customWidgetButton()
        return view
    }()
    
    var rightButton: UIButton! = {
        let view = customWidgetButton()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.accountLabel)
        self.addSubview(self.amountLabel)
        self.addSubview(self.leftButton)
        self.addSubview(self.rightButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

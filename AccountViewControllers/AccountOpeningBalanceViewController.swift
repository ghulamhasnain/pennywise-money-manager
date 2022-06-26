//
//  NewAccountOpeningBalanceViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 18/03/2019.
//  Copyright © 2019 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class AccountOpeningBalanceViewController: CustomCalculatorVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor
        self.buttonColor = myAltColor
        self.altColor = myColor
        self.title = "Enter Opening Balance"
        self.doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.donePressed))
    }
    
    @objc override func donePressed() {
        let location = navigationController?.viewControllers.index(before: (navigationController?.viewControllers.count)!-1)
        let nav = navigationController?.viewControllers[location!]
        let vc = nav as! AccountViewController
        vc.amount = amount
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
}

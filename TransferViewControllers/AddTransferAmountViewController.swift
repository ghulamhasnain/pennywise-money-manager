//
//  TransactionAmountViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 06/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class AddTransferAmountViewController: CustomCalculatorVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGray
        self.buttonColor = UIColor.lightGray
        self.altColor = UIColor.darkGray
        self.title = "Enter Amount"
        self.doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.donePressed))
        
    }
    
    // MARK: Helper funcs
    
    @objc override func donePressed() {
        let location = navigationController?.viewControllers.index(before: (navigationController?.viewControllers.count)!-1)
        let nav = navigationController?.viewControllers[location!]
        let vc = nav as! AddTransferViewController
        vc.amount = amount
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
}

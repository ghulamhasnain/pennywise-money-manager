//
//  TransactionDateViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 06/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class TransactionDateViewController: CustomDateVC {
    
    var income: Bool!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = income ? myGreen : myRed
        self.title = "Enter Date"
        
    }
    
    // MARK: Helper funcs
    
    @objc override func donePressed() {
        let location = navigationController?.viewControllers.index(before: (navigationController?.viewControllers.count)!-1)
        let nav = navigationController?.viewControllers[location!]
        let vc = nav as! TransactionViewController
        vc.date = datePicker.date
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
}

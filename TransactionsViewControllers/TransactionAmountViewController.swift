//
//  TransactionAmountViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 06/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class TransactionAmountViewController: CustomCalculatorVC {
    
    var income: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buttonColor = myGrey
        
        self.title = "Enter Amount"
        self.doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.donePressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = income ? myGreen : myRed
        self.altColor = income ? myGreen : myRed
    }
    
    // MARK: Helper funcs
    
    @objc override func donePressed() {
        let location = navigationController?.viewControllers.index(before: (navigationController?.viewControllers.count)!-1)
        let nav = navigationController?.viewControllers[location!]
        let vc = nav as! TransactionViewController
        vc.amount = amount
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
}

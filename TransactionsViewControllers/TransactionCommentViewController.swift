//
//  NewTransactionCommentViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 21/03/2019.
//  Copyright © 2019 Ghulam Hasnain. All rights reserved.
//

import UIKit

class TransactionCommentViewController: CustomCommentVC {
    
    var income: Bool!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = income ? myGreen : myRed
        self.title = "Enter Comment"
    }
    
    @objc override func donePressed() {
        let location = navigationController?.viewControllers.index(before: (navigationController?.viewControllers.count)!-1)
        let nav = navigationController?.viewControllers[location!]
        let vc = nav as! TransactionViewController
        vc.comment = commentTextView.text
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
}

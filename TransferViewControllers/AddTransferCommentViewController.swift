//
//  TransactionCommentViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 06/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class AddTransferCommentViewController: CustomCommentVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGray
        self.title = "Enter Comment"
    }
    
    // MARK: Helper funcs
    
    @objc override func donePressed() {
        let location = navigationController?.viewControllers.index(before: (navigationController?.viewControllers.count)!-1)
        let nav = navigationController?.viewControllers[location!]
        let vc = nav as! AddTransferViewController
        vc.comment = commentTextView.text
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
}

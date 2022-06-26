//
//  AddAccountViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 03/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class AccountNameViewController: UIViewController {
    
    var name: String!
    private var textField: UITextField!
    private var addAccountBarButtonItem: UIBarButtonItem!
    private var addAccountErrorAlert: UIAlertAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor
        
        // MARK: Set up the view
        self.title = "Add Name"
        
        addAccountBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(AccountNameViewController.saveAccount))
        self.navigationItem.rightBarButtonItem = addAccountBarButtonItem
        
        textField = UITextField(frame: CGRect(x: view.frame.maxX*0.025, y: view.frame.height/5, width: view.frame.width*0.95, height: view.frame.height/10))
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.white
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.font = myLargeFont
        textField.text = name
        textField.becomeFirstResponder()
        view.addSubview(textField)
        
    }
    
    // MARK: Helper funcs
    
    @objc func saveAccount() {
        if textField.hasText {
            let location = navigationController?.viewControllers.index(before: (navigationController?.viewControllers.count)!-1)
            let nav = navigationController?.viewControllers[location!]
            let vc = nav as! AccountViewController
            vc.name = textField.text
            navigationController?.popToViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Incorrect Information", message: "Please make sure the name field is filled.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
}

//
//  TransactionCategoryAddViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 10/03/2019.
//  Copyright © 2019 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class TransactionCategoryAddViewController: UIViewController {
    
    var income: Bool!
    var add: Bool!
    var category: NSManagedObject!
    var saveCategory: UIBarButtonItem!
    var categoryName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = add ? "Add Category" : "Edit Category"
        view.backgroundColor = income ? myGreen : myRed
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add the categoryName Text Field in the view
        categoryName = UITextField(frame: CGRect(x: view.frame.maxX*0.025, y: view.frame.height/5, width: view.frame.width*0.95, height: view.frame.height/10))
        categoryName.layer.borderColor = UIColor.lightGray.cgColor
        categoryName.layer.borderWidth = 1.0
        categoryName.layer.cornerRadius = 10
        categoryName.backgroundColor = UIColor.white
        categoryName.textAlignment = .center
        categoryName.returnKeyType = .done
        categoryName.font = myLargeFont
        categoryName.becomeFirstResponder()
        view.addSubview(categoryName)
        
        // If this is for Editing a Category
        if !add {
            categoryName.text = category.value(forKey: "name") as! String
        }
        
        // Add the "Save Category" button in the navbar
        saveCategory = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(TransactionCategoryAddViewController.saveCategoryPressed))
        self.navigationItem.rightBarButtonItem = saveCategory
    }
    
    @objc func saveCategoryPressed() {
        if categoryName.hasText {
            let name = categoryName.text!
            if add {
                addCategory(name: name, income: income)
                category = getCategory(name: name, income: income)
            } else {
                editCategory(category: category, name: name)
            }
            let location = navigationController?.viewControllers.index(before: (navigationController?.viewControllers.count)!-1)
            let nav = navigationController?.viewControllers[location!]
            let vc = nav as! TransactionCategoriesViewController
            vc.category = category
            vc.change = true
            navigationController?.popToViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Incorrect Information", message: "Please make sure the name field is filled.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
}

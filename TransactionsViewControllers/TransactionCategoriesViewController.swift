//
//  TransactionCategoriesViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 06/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class TransactionCategoriesViewController: UIViewController {
    
    var income: Bool!
    var category: NSManagedObject!
    var array: [NSManagedObject] = []
    var categoriesListTV: UITableView!
    var addCategory: UIBarButtonItem!
    var change: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select Category"
        self.navigationItem.hidesBackButton = true
        // In case of Income or Expense Transaction
        view.backgroundColor = income ? myGreen : myRed
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if categoriesListTV == nil {
            categoriesListTV = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            categoriesListTV.backgroundColor = UIColor.clear
            categoriesListTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            categoriesListTV.delegate = self
            categoriesListTV.dataSource = self
            view.addSubview(categoriesListTV)
            
            furnishArray()
            
        } else {
            if !array.contains(category) || change {
                array.removeAll()
                furnishArray()
                categoriesListTV.reloadData()
            }
        }
        
        // Add the "Add Category" button in the navbar
        addCategory = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TransactionCategoriesViewController.addCategorySegue))
        self.navigationItem.rightBarButtonItem = addCategory
    }
    
    // helper functions
    
    func furnishArray() {
        let allCategories = fetchModelInfo(modelName: "Category")
        for cat in allCategories {
            if cat.value(forKey: "income") as! Bool == income && cat.value(forKey: "name") as! String != "Transfer00Fr0m&2Acc0unts" {
                array.append(cat)
            }
        }
        array = sortArrayOfManagedObjectsByName(array: array)
    }
    
    @objc func addCategorySegue() {
        let vc: TransactionCategoryAddViewController = TransactionCategoryAddViewController()
        vc.income = income
        vc.add = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TransactionCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = array[indexPath.row].value(forKey: "name") as! String
        cell.textLabel?.textColor = UIColor.black
        cell.accessoryType = array[indexPath.row] == category ? .checkmark : .none
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/12
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if !checkTransactionsByCategory(category: self.array[indexPath.row]) {
                deleteItemFromModel(item: self.array[indexPath.row], modelName: "Category")
                self.array.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                let alert = UIAlertController(title: "Cannot delete Category", message: "Please make sure this category is not used in any transactions.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            self.category = self.array[indexPath.row]
            let vc: TransactionCategoryAddViewController = TransactionCategoryAddViewController()
            vc.income = self.income
            vc.add = false
            vc.category = self.array[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return [delete, edit]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = navigationController?.viewControllers.index(before: (navigationController?.viewControllers.count)!-1)
        let nav = navigationController?.viewControllers[location!]
        let vc = nav as! TransactionViewController
        vc.category = array[indexPath.row]
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
}



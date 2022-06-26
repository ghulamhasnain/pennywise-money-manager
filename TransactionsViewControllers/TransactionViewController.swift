//
//  TransactionViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 03/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class TransactionViewController: UIViewController {
    
    var array: [String] = ["Account", "Category", "Amount", "Date", "Comment"]
    var dict: [Int: String]!
    var amount: Double!
    
    var add: Bool!
    var transaction: NSManagedObject!
    var income: Bool!
    var account: NSManagedObject!
    var category: NSManagedObject!
    
    var date: Date!
    var comment: String = ""
    
    var categoryName: String!
    var saveBarButtonItem: UIBarButtonItem!
    
    private var addTransactionTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(TransactionViewController.saveTransaction))
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
        
        // Setup categories if needed
        
        let numberOfCategories = itemsCountInModel(modelName: "Category")
        if numberOfCategories == 0 {
            addBasicCategories()
        }
        
        // In case of Income or Expense Transaction
        if income {
            view.backgroundColor = myGreen
            self.title = add ? "Add Income" : "Edit Income"
        } else {
            view.backgroundColor = myRed
            self.title = add ? "Add Expense" : "Edit Expense"
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if addTransactionTV == nil {

            if add {

                date = Date()
                amount = 0

                // Set category value to be the first fetched category
                let allCategories = fetchCategoriesByType(income: income)
                category = allCategories.first
                categoryName = category.value(forKey: "name") as! String

            } else {
                category = transaction.value(forKey: "category") as! NSManagedObject
                date = transaction.value(forKey: "date") as! Date
                amount = transaction.value(forKey: "amount") as! Double
                account = transaction.value(forKey: "account") as! NSManagedObject
                comment = transaction.value(forKey: "comment") as! String
            }
        }
        
        categoryName = category.value(forKey: "name") as! String
        if categoryName == transferAccountName {
            categoryName = "Transfer"
        }
        
        // Setup dict
        dict = [0: account.value(forKey: "name") as? String] as! [Int : String]
        dict[1] = categoryName
        dict[2] = account.value(forKey: "currency") as! String + " " + doubleToString(double: amount)
        dict[3] = dateToString(date: date)
        dict[4] = comment != nil ? comment : ""

        // Setup the collection view
        
        addTransactionTV = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        addTransactionTV.backgroundColor = UIColor.clear
        addTransactionTV.dataSource = self
        addTransactionTV.delegate = self
        view.addSubview(addTransactionTV)

    }
    
    @objc func saveTransaction() {
        if add {
            addTransaction(account: account, category: category, amount: amount, comment: comment, date: date, income: income)
            navigationController?.popViewController(animated: true)
        } else {
            editTransaction(transaction: transaction, account: account, category: category, amount: amount, comment: comment, date: date, income: income)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func fetchCategoriesByType(income: Bool) -> [NSManagedObject] {
        var items: [NSManagedObject] = []
        let modelInfo = fetchModelInfo(modelName: "Category")
        for i in modelInfo {
            if i.value(forKey: "income") as! Bool == income {
                items.append(i)
            }
        }
        return items
    }
    
}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = myNormalFont
        
        cell.detailTextLabel?.text = dict[indexPath.row]
        cell.detailTextLabel?.textColor = income ? UIColor.gray : UIColor.white
        cell.detailTextLabel?.font = myNormalFont
        
        cell.backgroundColor = income ? myGreen : myRed
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc: TransactionAccountsViewController = TransactionAccountsViewController()
            vc.income = income
            vc.account = account
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            if category.value(forKey: "name") as! String != transferAccountName {
                let vc: TransactionCategoriesViewController = TransactionCategoriesViewController()
                vc.income = income
                vc.category = category
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let alert = UIAlertController(title: "This is a transfer", message: "You cannot change the category of a transfer.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        case 2:
            let vc: TransactionAmountViewController = TransactionAmountViewController(amount: amount)
            vc.income = income
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc: TransactionDateViewController = TransactionDateViewController(date: date)
            vc.income = income
//            vc.date = date
            navigationController?.pushViewController(vc, animated: true)
        case 4:
//            let vc: TransactionCommentViewController = TransactionCommentViewController()
            let vc: TransactionCommentViewController = TransactionCommentViewController(comment: comment)
            vc.income = income
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}

//
//  TransactionViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 03/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class AddTransferViewController: UIViewController {
    
    var accountsList: [NSManagedObject]!
    
    var array: [String] = ["From Account", "To Account", "Amount", "Rate", "Date", "Comment"]
    var dict: [Int: String]!
    
    var fromAccount: NSManagedObject!
    var toAccount: NSManagedObject!
    var fromCategory: NSManagedObject!
    var toCategory: NSManagedObject!
    var amount: Double!
    var rate: Double!
    var date: Date!
    var comment: String = ""
    
    var saveBarButtonItem: UIBarButtonItem!
    
    private var addTransactionTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountsList = fetchModelInfo(modelName: "Account")
        
        saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(TransactionViewController.saveTransaction))
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
        
        // Setup categories if needed
        
        let numberOfCategories = itemsCountInModel(modelName: "Category")
        if numberOfCategories == 0 {
            addBasicCategories()
        }
        
        // In case of Income or Expense Transaction
        view.backgroundColor = UIColor.darkGray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if addTransactionTV == nil {
            date = Date()
            amount = 0
            rate = 1
        }
        
        // Setup dict
        dict = [0: fromAccount.value(forKey: "name") as? String] as! [Int : String]
        dict[1] = toAccount.value(forKey: "name") as? String
        dict[2] = fromAccount.value(forKey: "currency") as! String + " " + doubleToString(double: amount)
        dict[3] = doubleToString(double: rate)
        dict[4] = dateToString(date: date)
        dict[5] = comment != nil ? comment : ""
        
        // Setup the collection view
        
        addTransactionTV = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        addTransactionTV.backgroundColor = UIColor.clear
        addTransactionTV.dataSource = self
        addTransactionTV.delegate = self
        addTransactionTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(addTransactionTV)
        
        let allCategories = CoreDataManager(modelName: "Category").fetchedResults()
        for cat in allCategories {
            if cat.value(forKey: "name") as! String == transferAccountName && cat.value(forKey: "income") as! Bool == false {
                fromCategory = cat
            }
            if cat.value(forKey: "name") as! String == transferAccountName && cat.value(forKey: "income") as! Bool == true {
                toCategory = cat
            }
        }
    }
    
    @objc func saveTransaction() {
        if amount == Double(0) {
            let alert = UIAlertController(title: "Incorrect Information", message: "Please make sure amount is more than 0.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        } else if fromAccount == toAccount {
            let alert = UIAlertController(title: "Incorrect Information", message: "The account from which money is being transferred cannot be the same as the one being transferred to.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        } else if rate == Double(0) {
            let alert = UIAlertController(title: "Incorrect Information", message: "Please make sure rate is not 0.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        } else {
            let toTransferAmount: Double = amount * rate
            
            addTransaction(account: fromAccount, category: fromCategory, amount: amount, comment: comment, date: date, income: false)
            addTransaction(account: toAccount, category: toCategory, amount: toTransferAmount, comment: comment, date: date, income: true)
        
            navigationController?.popViewController(animated: true)
        }
    }
    
}

extension AddTransferViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = myNormalFont
        
        cell.detailTextLabel?.text = dict[indexPath.row]
        cell.detailTextLabel?.textColor = myColor
        cell.detailTextLabel?.font = myNormalFont
        
        cell.backgroundColor = UIColor.darkGray
        cell.accessoryType = .disclosureIndicator
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc: AddTransferAccountViewController = AddTransferAccountViewController()
            vc.account = fromAccount
            vc.from = true
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc: AddTransferAccountViewController = AddTransferAccountViewController()
            vc.account = toAccount
            vc.from = false
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc: AddTransferAmountViewController = AddTransferAmountViewController(amount: self.amount)
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc: AddTransferRateViewController = AddTransferRateViewController(amount: rate)
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc: AddTransferDateViewController = AddTransferDateViewController(date: date)
            navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc: AddTransferCommentViewController = AddTransferCommentViewController(comment: comment)
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}

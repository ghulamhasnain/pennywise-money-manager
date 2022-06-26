//
//  TransactionAccountsViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 06/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class AddTransferAccountViewController: UIViewController {
    
    var account: NSManagedObject!
    var from: Bool!
    var array: [NSManagedObject] = []
    var accountsListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select Account"
        
        // In case of Income or Expense Transaction
        view.backgroundColor = UIColor.darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        accountsListTV = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        accountsListTV.backgroundColor = UIColor.clear
        accountsListTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        accountsListTV.delegate = self
        accountsListTV.dataSource = self
        view.addSubview(accountsListTV)
        
        array = fetchModelInfo(modelName: "Account")
    }
    
}

extension AddTransferAccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        let balance = array[indexPath.row].value(forKey: "balance") as! Double
        let currency = array[indexPath.row].value(forKey: "currency") as! String
        
        cell.textLabel?.text = array[indexPath.row].value(forKey: "name") as! String
        cell.textLabel?.textColor = UIColor.white
        cell.accessoryType = array[indexPath.row] == account ? .checkmark : .none
        
        cell.detailTextLabel?.text = currency + " " + doubleToString(double: balance)
        cell.detailTextLabel?.textColor = myColor
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = navigationController?.viewControllers[1] as! AddTransferViewController
        if from {
            vc.fromAccount = array[indexPath.row]
        } else {
            vc.toAccount = array[indexPath.row]
        }
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
}


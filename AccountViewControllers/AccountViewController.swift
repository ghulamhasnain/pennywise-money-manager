//
//  NewAccountViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 18/03/2019.
//  Copyright © 2019 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class AccountViewController: UIViewController {
    
    private var array: [String] = ["Name", "Currency", "Opening Balance"]
    private var dict: [Int: String]!
    
    var amount: Double!
    var name: String!
    var currency: String!
    var add: Bool!
    var account: NSManagedObject!
    var saveButton: UIBarButtonItem!
    
    private var addAccountTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor
        self.title = add ? "Add Account" : "Edit Account"
        
        // Add a save button to the ui
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveAccount))
        navigationItem.rightBarButtonItem = self.saveButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if addAccountTV == nil {
            if add {
                name = "Cash in Hand"
                self.amount = 0
                currency = Array(listOfCurrenciesDetail.keys).sorted().first
            } else {
                name = account.value(forKey: "name") as! String
                currency = account.value(forKey: "currency") as! String
                self.amount = account.value(forKey: "openingBalance") as! Double
            }
        }
        
        // Setup dict
        dict = [0: name]
        dict[1] = currency
        dict[2] = doubleToString(double: self.amount)
        
        // Setup Table View
        addAccountTV = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        addAccountTV.backgroundColor = myColor
        addAccountTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        addAccountTV.delegate = self
        addAccountTV.dataSource = self
        view.addSubview(addAccountTV)
        
    }
    
    @objc func saveAccount() {
        if add {
            addAccount(name: name, currency: currency, openingBalance: self.amount)
            navigationController?.popViewController(animated: true)
        } else {
            editAccount(account: account, name: name, currency: currency, openingBalance: self.amount)
            navigationController?.popViewController(animated: true)
        }
    }
    
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.font = myNormalFont
        
        cell.detailTextLabel?.text = dict[indexPath.row]
        cell.detailTextLabel?.font = myNormalFont
        
        cell.backgroundColor = UIColor.clear
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc: AccountNameViewController = AccountNameViewController()
            vc.name = dict[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc: AccountCurrencyViewController = AccountCurrencyViewController()
            vc.currency = dict[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc: AccountOpeningBalanceViewController = AccountOpeningBalanceViewController(amount: self.amount)
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}

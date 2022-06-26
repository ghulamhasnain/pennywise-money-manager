//
//  AccountsListViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 03/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class AccountsListViewController: UIViewController {
    
    var array: [NSManagedObject] = []
    var accountsListTV: UITableView!
    var addAccount: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // MARK: Set up table view
        
        accountsListTV = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        accountsListTV.backgroundColor = myColor
        accountsListTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        accountsListTV.delegate = self
        accountsListTV.dataSource = self
        view.addSubview(accountsListTV)
        
        array = fetchModelInfo(modelName: "Account")
        array = sortArrayOfManagedObjectsByName(array: array)
        addAccount = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AccountsListViewController.addAccountSegue))
        self.navigationItem.rightBarButtonItem = addAccount
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if (accountsListTV != nil) {
            array.removeAll()
            let items = accountsListTV.numberOfRows(inSection: 0)
            let indexPaths = [Int](0..<items).map {
                IndexPath(row: $0, section: 0)
            }
            accountsListTV.deleteRows(at: indexPaths, with: .none)
        }
    }
    
    // Helper funcs
    
    @objc func addAccountSegue() {
//        let vc: AccountViewController = AccountViewController()
        let vc: AccountViewController = AccountViewController()
        vc.add = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension AccountsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        let currency = array[indexPath.row].value(forKey: "currency") as! String
        let balance = array[indexPath.row].value(forKey: "balance") as! Double
        let name = array[indexPath.row].value(forKey: "name") as! String
        
        cell.detailTextLabel!.text = currency + " " + doubleToString(double: balance)
        cell.detailTextLabel?.textColor = UIColor.black
        cell.detailTextLabel?.font = myNormalFont
        
        cell.textLabel!.text = name
        cell.textLabel!.font = myNormalFont
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            deleteItemFromModel(item: self.array[indexPath.row], modelName: "Account")
            UserDefaults.standard.set(0, forKey: "defaultAccountRow")
            self.array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            let account = self.array[indexPath.row]
            let vc: AccountViewController = AccountViewController()
            vc.account = account
            vc.add = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return [delete, edit]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: TransactionsListViewController = TransactionsListViewController()
        vc.account = array[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

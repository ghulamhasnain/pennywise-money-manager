//
//  ViewTransactionsController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 21/11/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class TransactionsListViewController: UIViewController {
    
    var account: NSManagedObject!
    
    private var array: [NSManagedObject] = []
    private var finalArray: [NSManagedObject] = []
    private var balanceArray: [Double] = []
    private var balance: Double!
    private var date: Date = Date()
    private var transactionsTV: UITableView!
    private var upButton: UIBarButtonItem!
    private var downButton: UIBarButtonItem!
    private var monthLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = myColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // Page title
        self.title = account.value(forKey: "name") as! String
        
        // Month label
        let navMaxY = navigationController?.navigationBar.frame.maxY
        let navHeight = navigationController?.navigationBar.frame.height
        monthLabel = UILabel(frame: CGRect(x: 0, y: navMaxY!, width: view.frame.width, height: navHeight!))
        monthLabel.font = myNormalFont
        monthLabel.layer.cornerRadius = 5
        monthLabel.layer.borderColor = UIColor.black.cgColor
        monthLabel.backgroundColor = UIColor.lightGray
        monthLabel.textAlignment = .center
        monthLabel.text = dateToStringForLabel(date: date)
        monthLabel.textColor = UIColor.white
        view.addSubview(monthLabel)
        
        // Setup TableView
        transactionsTV = UITableView(frame: CGRect(x: 0, y: monthLabel.frame.maxY, width: view.frame.width, height: view.frame.height))
        transactionsTV.backgroundColor = UIColor.clear
        transactionsTV.dataSource = self
        transactionsTV.delegate = self
        transactionsTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        transactionsTV.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.addSubview(transactionsTV)
        
        // One page appearance
        array = fetchTransactionsByAccount(account: account)
        refreshData()
        
        // Setup bar buttons
        
        let upImage = UIImage(named: "up")
        upButton = UIBarButtonItem(image: upImage, style: .plain, target: self, action: #selector(TransactionsListViewController.upButtonPressed))
        
        let downImage = UIImage(named: "down")
        downButton = UIBarButtonItem(image: downImage, style: .plain, target: self, action: #selector(TransactionsListViewController.downButtonPressed))
        
        navigationItem.rightBarButtonItems = [upButton, downButton]
        
    }
    
    func refreshData() {
        balance = account.value(forKey: "balance") as! Double
        let startOfMonth = getStartAndEndOfMonth(date: date)[0]
        let endOfMonth = getStartAndEndOfMonth(date: date)[1]
        finalArray.removeAll()
        balanceArray.removeAll()
        for a in array {
            let income = a.value(forKey: "income") as! Bool
            let amount = a.value(forKey: "amount") as! Double
            let date = a.value(forKey: "date") as! Date
            
            if date >= startOfMonth && date <= endOfMonth {
                finalArray.append(a)
                balanceArray.append(balance)
            }
            balance = income ? balance - amount : balance + amount
        }
        transactionsTV.reloadData()
    }
    
    @objc func downButtonPressed() {
        let nextMonth = getNextMonth(date: date)
        date = nextMonth
        monthLabel.text = dateToStringForLabel(date: date)
        refreshData()
    }
    
    @objc func upButtonPressed() {
        let previousMonth = getPreviousMonth(date: date)
        date = previousMonth
        monthLabel.text = dateToStringForLabel(date: date)
        refreshData()
    }
    
}

extension TransactionsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        let object = finalArray[indexPath.row]
        let date = object.value(forKey: "date") as! Date
        let currency = account.value(forKey: "currency") as! String
        let amount = object.value(forKey: "amount") as! Double
        let category = object.value(forKey: "category") as! NSManagedObject
        let comment = object.value(forKey: "comment") as! String
        let income = object.value(forKey: "income") as! Bool
        
        cell.leftLabel.text = dateToString(date: date)
        cell.rightLabel.text = currency + " " + doubleToString(double: amount)
        
        var categoryName = category.value(forKey: "name") as! String
        if categoryName == transferAccountName {
            categoryName = "Transfer"
        }
        cell.commentLabel.text = categoryName + " - " + comment
        cell.lowerRightLabel.text = currency + " " + doubleToString(double: balanceArray[indexPath.row])
        
        cell.backgroundColor = object.value(forKey: "income") as! Bool == true ? myGreen : myRed
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.25
        balance = income ? balance - amount : balance + amount
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc: TransactionViewController = TransactionViewController()
        vc.transaction = finalArray[indexPath.row]
        vc.income = finalArray[indexPath.row].value(forKey: "income") as! Bool
        vc.add = false
        
        self.finalArray.removeAll()
        transactionsTV.reloadData()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let deletedTransaction = self.finalArray[indexPath.row]
            deleteTransaction(transaction: deletedTransaction)
            self.finalArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.array = fetchTransactionsByAccount(account: self.account)
                self.refreshData()
            })
        }
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/8
    }
    
}

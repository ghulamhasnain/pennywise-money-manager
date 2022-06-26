//
//  CoreDataManager.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 02/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class PersistentContainer: NSPersistentContainer{
    override class func defaultDirectoryURL() -> URL{
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.PennyWiseData")!
    }
    
    override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
    }
}

final class CoreDataManager {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // App Delegate
    public lazy var appDelegate = {
        return UIApplication.shared.delegate
        }() as! AppDelegate
    
    // Managed Object Context
    public lazy var managedContext: NSManagedObjectContext = {
        return appDelegate.persistentContainer.viewContext
    }()
    
    // Fetch Request
    public lazy var fetchRequest = {
        return NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
    }()
    
    func entityCount() -> Int {
        let count: Int! = try? self.managedContext.count(for: self.fetchRequest)
        return count
    }
    
    func fetchedResults() -> [NSManagedObject] {
        let count: Int! = self.entityCount()
        var array: [NSManagedObject] = []
        if count != 0 {
            do {
                let result = try self.managedContext.fetch(self.fetchRequest)
                array = result as! [NSManagedObject]
            } catch {
                
            }
        }
        
        return array
    }
    
    func newEntry() -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: modelName, in: self.managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: self.managedContext)
        return item
    }
    
}

// General funcs

func itemsCountInModel(modelName: String) -> Int {
    let modelDataManager = CoreDataManager(modelName: modelName)
    return modelDataManager.entityCount()
}

func fetchModelInfo(modelName: String) -> [NSManagedObject] {
    let modelDataManager = CoreDataManager(modelName: modelName)
    let fetchRequest = modelDataManager.fetchRequest
    var results = try? modelDataManager.managedContext.fetch(fetchRequest)
    return results as! [NSManagedObject]
}

func deleteItemFromModel(item: NSManagedObject, modelName: String) {
    let modelDataManager = CoreDataManager(modelName: modelName)
    modelDataManager.managedContext.delete(item)
    do {
        try? modelDataManager.managedContext.save()
    } catch {
        print("error")
    }
    
}

// Specific funcs

func addTransaction(account: NSManagedObject, category: NSManagedObject, amount: Double, comment: String, date: Date, income: Bool) {
    let transactionDataManager = CoreDataManager(modelName: "Transaction")
    let transactionItem = transactionDataManager.newEntry()
    transactionItem.setValue(account, forKey: "account")
    transactionItem.setValue(category, forKey: "category")
    transactionItem.setValue(date, forKey: "date")
    transactionItem.setValue(income, forKey: "income")
    transactionItem.setValue(amount, forKey: "amount")
    transactionItem.setValue(comment, forKey: "comment")
    do {
        try transactionDataManager.managedContext.save()
    } catch {
        print("error")
    }
    
    // Change balance of relevant account
    let oldAccountBalance: Double = account.value(forKey: "balance") as! Double
    let newAccountBalance = income ? oldAccountBalance + amount : oldAccountBalance - amount
    editAccountBalance(account: account, newBalance: newAccountBalance)
}

func editTransaction(transaction: NSManagedObject, account: NSManagedObject, category: NSManagedObject, amount: Double, comment: String, date: Date, income: Bool) {
    var transactionItem: NSManagedObject!
    let transactionDataManager = CoreDataManager(modelName: "Transaction")
    let allTransactions = transactionDataManager.fetchedResults()
    for t in allTransactions {
        if t == transaction {
            transactionItem = t
        }
    }
    let oldAmount: Double = transactionItem.value(forKey: "amount") as! Double
    
    if transactionItem.value(forKey: "account") as! NSManagedObject != account {
        let oldAccount = transactionItem.value(forKey: "account") as! NSManagedObject
        let oldAccountOldBalance: Double = oldAccount.value(forKey: "balance") as! Double
        let oldAccountNewBalance: Double = income ? oldAccountOldBalance - oldAmount : oldAccountOldBalance + oldAmount
        let newAccountOldBalance = account.value(forKey: "balance") as! Double
        let newAccountNewBalance = income ? newAccountOldBalance + amount : newAccountOldBalance - amount
        editAccountBalance(account: oldAccount, newBalance: oldAccountNewBalance)
        editAccountBalance(account: account, newBalance: newAccountNewBalance)
        transactionItem.setValue(account, forKey: "account")
    } else {
        let oldAccountBalance: Double = account.value(forKey: "balance") as! Double
        let newAccountBalance = income ? oldAccountBalance + amount - oldAmount : oldAccountBalance - amount + oldAmount
        editAccountBalance(account: account, newBalance: newAccountBalance)
    }
    transactionItem.setValue(amount, forKey: "amount")
    transactionItem.setValue(comment, forKey: "comment")
    transactionItem.setValue(date, forKey: "date")
    transactionItem.setValue(income, forKey: "income")
    transactionItem.setValue(category, forKey: "category")
    do {
        try transactionDataManager.managedContext.save()
    } catch {
        print("error") // fix issue
    }
    
}

func addAccount(name: String, currency: String, openingBalance: Double) {
    let accountDataManager = CoreDataManager(modelName: "Account")
    let fetchRequest = accountDataManager.fetchRequest
    var results = try? accountDataManager.managedContext.fetch(fetchRequest)
    let count = results?.count
    let id = count == 0 ? 1 : (results!.last as! NSManagedObject).value(forKey: "id") as! Double + 1
    
    let accountItem = accountDataManager.newEntry()
    accountItem.setValue(id, forKey: "id")
    accountItem.setValue(name, forKey: "name")
    accountItem.setValue(currency, forKey: "currency")
    accountItem.setValue(openingBalance, forKey: "openingBalance")
    accountItem.setValue(openingBalance, forKey: "balance")
    do {
        try accountDataManager.managedContext.save()
    } catch {
        print("error")
    }
}

func deleteAccount(account: NSManagedObject) {
    let data = fetchModelInfo(modelName: "Account")
    for d in data {
        if d == account {
            deleteItemFromModel(item: d, modelName: "Account")
            break
        }
    }
}

func editAccount(account: NSManagedObject, name: String, currency: String, openingBalance: Double) {
    let accountDataManager = CoreDataManager(modelName: "Account")
    let fetchRequest = accountDataManager.fetchRequest
    var results: [NSManagedObject] = try! accountDataManager.managedContext.fetch(fetchRequest) as! [NSManagedObject]
    for r in results {
        if r == account {
            let ogOpeningBalance = r.value(forKey: "openingBalance") as! Double
            let ogBalance = r.value(forKey: "balance") as! Double
            r.setValue(name, forKey: "name")
            r.setValue(currency, forKey: "currency")
            r.setValue(openingBalance, forKey: "openingBalance")
            r.setValue(ogBalance - ogOpeningBalance + openingBalance, forKey: "balance")
            break
        }
    }
    do {
        try accountDataManager.managedContext.save()
    } catch {
        print("error")
    }
}

func editAccountBalance(account: NSManagedObject, newBalance: Double) {
    let accountDataManager = CoreDataManager(modelName: "Account")
    let fetchRequest = accountDataManager.fetchRequest
    var results: [NSManagedObject] = try! accountDataManager.managedContext.fetch(fetchRequest) as! [NSManagedObject]
    for r in results {
        if r == account {
            r.setValue(newBalance, forKey: "balance")
            break
        }
    }
    do {
        try accountDataManager.managedContext.save()
    } catch {
        print("error")
    }
}

func addCategory(name: String, income: Bool) {
    let categoryDataManager = CoreDataManager(modelName: "Category")
    let categoryItem = categoryDataManager.newEntry()
    categoryItem.setValue(name, forKey: "name")
    categoryItem.setValue(income, forKey: "income")
    do {
        try categoryDataManager.managedContext.save()
    } catch {
        print("error")
    }
}

func editCategory(category: NSManagedObject, name: String) {
    let accountDataManager = CoreDataManager(modelName: "Category")
    let fetchRequest = accountDataManager.fetchRequest
    var results: [NSManagedObject] = try! accountDataManager.managedContext.fetch(fetchRequest) as! [NSManagedObject]
    for r in results {
        if r == category {
            r.setValue(name, forKey: "name")
            break
        }
    }
    do {
        try accountDataManager.managedContext.save()
    } catch {
        print("error")
    }
}

func getCategory(name: String, income: Bool) -> NSManagedObject {
    let dataManager = CoreDataManager(modelName: "Category")
    let fetchRequest = dataManager.fetchRequest
    var results: [NSManagedObject]! = []
    do {
        results = try dataManager.managedContext.fetch(fetchRequest) as! [NSManagedObject]
    } catch {
        print("error")
    }
    
    var finalResults: NSManagedObject!
    for r in results {
        if r.value(forKey: "name") as! String == name {
            finalResults = r
        }
    }
    return finalResults
}

func fetchTransactionsByAccount(account: NSManagedObject) -> [NSManagedObject] {
    let dataManager = CoreDataManager(modelName: "Transaction")
    let fetchRequest = dataManager.fetchRequest
    let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
    fetchRequest.sortDescriptors = [sortDescriptor]
    var results: [NSManagedObject]! = []
    do {
        results = try dataManager.managedContext.fetch(fetchRequest) as! [NSManagedObject]
    } catch {
        print("error")
    }
    
    var finalResults: [NSManagedObject]! = []
    for r in results {
        if r.value(forKey: "account") as! NSManagedObject == account {
            finalResults.append(r)
        }
    }
    return finalResults
}

func checkTransactionsByCategory(category: NSManagedObject) -> Bool {
    let dataManager = CoreDataManager(modelName: "Transaction")
    let fetchRequest = dataManager.fetchRequest
    var results: [NSManagedObject]! = []
    do {
        results = try dataManager.managedContext.fetch(fetchRequest) as! [NSManagedObject]
    } catch {
        print("error")
    }

    for r in results {
        if r.value(forKey: "category") as! NSManagedObject == category {
            return true
            break
        }
    }
    return false
}

func getStartAndEndOfMonth(date: Date) -> [Date] {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: date)
    let startOfMonth: Date = calendar.date(from: components)!
    var components2 = DateComponents()
    components2.month = 1
    let endOfMonth: Date = calendar.date(byAdding: components2, to: startOfMonth)!
    return [startOfMonth, endOfMonth]
}

func getNextMonth(date: Date) -> Date {
    let calendar = Calendar.current
    var components = calendar.dateComponents([.year, .month], from: date)
    components.day = 15
    let startOfMonth: Date = calendar.date(from: components)!
    var components2 = DateComponents()
    components2.month = 1
    let nextMonth: Date = calendar.date(byAdding: components2, to: startOfMonth)!
    return nextMonth
}

func getPreviousMonth(date: Date) -> Date {
    let calendar = Calendar.current
    var components = calendar.dateComponents([.year, .month], from: date)
    components.day = 15
    let startOfMonth: Date = calendar.date(from: components)!
    var components2 = DateComponents()
    components2.month = -1
    let previousMonth: Date = calendar.date(byAdding: components2, to: startOfMonth)!
    return previousMonth
}

func fetchTransactionsOfMonth(account: NSManagedObject, date: Date) -> [NSManagedObject] {
    let dataManager = CoreDataManager(modelName: "Transaction")
    let fetchRequest = dataManager.fetchRequest
    let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
    
    // Get start and end of month
    let startOfMonth = getStartAndEndOfMonth(date: date)[0]
    let endOfMonth = getStartAndEndOfMonth(date: date)[1]
    fetchRequest.predicate = NSPredicate(format: "date >= %@ && date <= %@", startOfMonth as CVarArg, endOfMonth as CVarArg)
    fetchRequest.sortDescriptors = [sortDescriptor]
    var results: [NSManagedObject]! = []
    do {
        results = try dataManager.managedContext.fetch(fetchRequest) as! [NSManagedObject]
    } catch {
        print("error")
    }
    
    var finalResults: [NSManagedObject]! = []
    for r in results {
        if r.value(forKey: "account") as! NSManagedObject == account {
            finalResults.append(r)
        }
    }
    return finalResults
}

func fetchFutureTransactions(account: NSManagedObject, date: Date) -> [NSManagedObject] {
    let dataManager = CoreDataManager(modelName: "Transaction")
    let fetchRequest = dataManager.fetchRequest
    let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
    let endOfMonth = getStartAndEndOfMonth(date: date)[1]
    
    fetchRequest.predicate = NSPredicate(format: "date > %@", endOfMonth as CVarArg)
    fetchRequest.sortDescriptors = [sortDescriptor]
    var results: [NSManagedObject]! = []
    do {
        results = try dataManager.managedContext.fetch(fetchRequest) as! [NSManagedObject]
    } catch {
        print("error")
    }
    
    var finalResults: [NSManagedObject]! = []
    for r in results {
        if r.value(forKey: "account") as! NSManagedObject == account {
            finalResults.append(r)
        }
    }
    return finalResults
}

func deleteTransaction(transaction: NSManagedObject) {
    let account: NSManagedObject = transaction.value(forKey: "account") as! NSManagedObject
    
    let amount: Double = transaction.value(forKey: "amount") as! Double
    let oldAccountBalance: Double = account.value(forKey: "balance") as! Double
    let newAccountBalance = transaction.value(forKey: "income") as! Bool ? oldAccountBalance - amount : oldAccountBalance + amount
    editAccountBalance(account: account, newBalance: newAccountBalance)
    
    deleteItemFromModel(item: transaction, modelName: "Transaction")
}

func updateAccountsDataInUserDefaults() {
    let modelInfo = fetchModelInfo(modelName: "Account")
    let countOfModelInfo = modelInfo.count
    var info = [String: String]()
    for i in 0..<countOfModelInfo {
        let name = String(modelInfo[i].value(forKey: "id") as! Int) + ". " + String(modelInfo[i].value(forKey: "name") as! String)
        let currency = modelInfo[i].value(forKey: "currency") as! String
        let balance = modelInfo[i].value(forKey: "balance") as! Double
        info[name] = currency + " " + doubleToString(double: balance)
    }
    if let userDefaults = UserDefaults(suiteName: "group.PennyWiseData") {
        userDefaults.set(info as [String: String], forKey: "info")
        userDefaults.synchronize()
    }

}

func sortArrayOfManagedObjectsByName(array: [NSManagedObject]) -> [NSManagedObject] {
    let sortedArray = array.sorted { (first, second) -> Bool in
        (first.value(forKey: "name") as! String).localizedCaseInsensitiveCompare(second.value(forKey: "name") as! String) == ComparisonResult.orderedAscending
    }
    return sortedArray
}

func addBasicCategories() {

        addCategory(name: "Salary", income: true)
        addCategory(name: "Rent", income: true)
        addCategory(name: "Bonus", income: true)
        addCategory(name: "Contract", income: true)
        addCategory(name: "Stocks", income: true)
        addCategory(name: transferAccountName, income: true)
        
        addCategory(name: "Groceries", income: false)
        addCategory(name: "Apparel", income: false)
        addCategory(name: "Bank charges", income: false)
        addCategory(name: "Fuel", income: false)
        addCategory(name: "Insurance", income: false)
        addCategory(name: "Donation", income: false)
        addCategory(name: "Medical", income: false)
        addCategory(name: "Other", income: false)
        addCategory(name: "Transfer00Fr0m&2Acc0unts", income: false)

}

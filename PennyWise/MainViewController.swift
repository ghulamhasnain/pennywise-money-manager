//
//  ViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 28/06/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    // Constants and Variables
    
    var array: [NSManagedObject] = []
    private var accountBalancesLayout: UICollectionViewFlowLayout!
    private var accountBalancesCV:UICollectionView!
    private var accountsListButton: UIBarButtonItem!
    private var accountBalancesPC: UIPageControl!
    private var addIncome: CustomMainButton!
    private var addExpense: CustomMainButton!
    private var addTransfer: CustomMainButton!
    private var addTransferLabel: CustomMainButtonLabel!
    private var addIncomeLabel: CustomMainButtonLabel!
    private var addExpenseLabel: CustomMainButtonLabel!
    private var viewTransactions: UIButton!
    private var window: UIScrollView!
    
    // Override funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Penny Wise"
        
        if (accountBalancesCV != nil) {
            array.removeAll()
            let items = accountBalancesCV.numberOfItems(inSection: 0)
            let indexPaths = [Int](0..<items).map {
                IndexPath(row: $0, section: 0)
            }
            accountBalancesCV.deleteItems(at: indexPaths)
            accountBalancesPC.numberOfPages = 0
        }
        
        // Fetching account info to fill the array
        
        let numberOfAccounts = itemsCountInModel(modelName: "Account")
        if numberOfAccounts == 0 {
            addAccount(name: "Cash in Hand", currency: "GBP", openingBalance: 0)
        }
        array = fetchModelInfo(modelName: "Account")
        
        // MARK: Setting up the views
        
        /// MARK: Bar button item
        accountsListButton = UIBarButtonItem(title: "℀", style: .plain, target: self, action: #selector(MainViewController.accountsList))
        accountsListButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = accountsListButton
        
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        let viewMaxX = view.frame.maxX
        let viewMaxY = view.frame.maxY
        
        let buttonWidth = viewWidth/5
        
        /// MARK: UIView
        window = UIScrollView(frame: CGRect(x: 0, y: viewHeight/5, width: viewWidth, height: viewHeight/3))
        window.backgroundColor = UIColor.clear
        window.isPagingEnabled = true
        view.addSubview(window)
        
        accountBalancesLayout = UICollectionViewFlowLayout()
        accountBalancesLayout.sectionInset = UIEdgeInsets(top: 10, left: window.frame.width*0.03, bottom: 10, right: window.frame.width*0.03)
        accountBalancesLayout.itemSize = CGSize(width: window.frame.width*0.94, height: window.frame.height*0.75)
        accountBalancesLayout.scrollDirection = .horizontal
        
        accountBalancesCV = UICollectionView(frame: CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height), collectionViewLayout: accountBalancesLayout)
        accountBalancesCV.dataSource = self
        accountBalancesCV.delegate = self
        accountBalancesCV.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        accountBalancesCV.backgroundColor = UIColor.clear
        accountBalancesCV.isPagingEnabled = true
        accountBalancesCV.showsHorizontalScrollIndicator = false
        accountBalancesCV.showsVerticalScrollIndicator = false
        window.addSubview(accountBalancesCV)
        
        accountBalancesPC = UIPageControl(frame: CGRect(x: 0, y: window.frame.height - 12, width: window.frame.width, height: 10))
        accountBalancesPC.numberOfPages = array.count
        accountBalancesPC.currentPageIndicatorTintColor = UIColor.black
        accountBalancesPC.pageIndicatorTintColor = UIColor.lightGray
        window.addSubview(accountBalancesPC)
        
        let viewTransactionsButtonSquare = window.frame.width / 7
        viewTransactions = UIButton(frame: CGRect(x: view.frame.width * 0.97 - viewTransactionsButtonSquare, y: window.frame.maxY * 0.375, width: viewTransactionsButtonSquare, height: viewTransactionsButtonSquare))
        viewTransactions.setTitle("ⓘ", for: .normal)
        viewTransactions.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        viewTransactions.setTitleColor(UIColor.black, for: .normal)
        viewTransactions.addTarget(self, action: #selector(MainViewController.viewTransactionsPressed), for: .touchDown)
        window.addSubview(viewTransactions)
        
        addIncome = CustomMainButton(frame: CGRect(x: viewMaxX/4 - viewWidth/10, y: (viewMaxY + window.frame.maxY)/2 - viewWidth/10, width: buttonWidth, height: buttonWidth))
        addIncome.backgroundColor = myGreen
        addIncome.setTitle("➕", for: .normal)
        addIncome.addTarget(self, action: #selector(MainViewController.addIncomePressed), for: .touchDown)
        view.addSubview(addIncome)
        
        addIncomeLabel = CustomMainButtonLabel(frame: CGRect(x: viewMaxX/4 - viewWidth/4, y: addIncome.frame.maxY, width: viewWidth/2, height: 50.0))
        addIncomeLabel.text = "Add Income"
        view.addSubview(addIncomeLabel)
        
        addExpense = CustomMainButton(frame: CGRect(x: viewMaxX*3/4 - viewWidth/10, y: (viewMaxY + window.frame.maxY)/2 - viewWidth/10, width: buttonWidth, height: buttonWidth))
        addExpense.backgroundColor = myRed
        addExpense.setTitle("➖", for: .normal)
        addExpense.addTarget(self, action: #selector(MainViewController.addExpensePressed), for: .touchDown)
        view.addSubview(addExpense)
        
        addExpenseLabel = CustomMainButtonLabel(frame: CGRect(x: viewMaxX*3/4 - viewWidth/4, y: addExpense.frame.maxY, width: viewWidth/2, height: 50.0))
        addExpenseLabel.text = "Add Expense"
        view.addSubview(addExpenseLabel)
        
        let transferButtonY = addExpense.frame.minY
        let transferButtonX = viewMaxX/2 - buttonWidth/2
        addTransfer = CustomMainButton(frame: CGRect(x: transferButtonX, y: transferButtonY, width: buttonWidth, height: buttonWidth))
        addTransfer.backgroundColor = UIColor.darkGray
        addTransfer.setTitle("→", for: .normal)
        addTransfer.addTarget(self, action: #selector(MainViewController.transferPressed), for: .touchDown)
        view.addSubview(addTransfer)
        
        let transferLabelX = view.frame.maxX/2 - buttonWidth/2
        addTransferLabel = CustomMainButtonLabel(frame: CGRect(x: transferLabelX, y: addTransfer.frame.maxY, width: buttonWidth, height: 50.0))
        addTransferLabel.text = "Transfer"
        view.addSubview(addTransferLabel)
        
        // UserDefaults setup
        
        let indexOfMajorCell = self.indexOfMajorCell()
        let userDefault = UserDefaults.standard.integer(forKey: "defaultAccountRow")
        if userDefault != indexOfMajorCell {
            let indexPath = IndexPath(row: userDefault, section: 0)
            accountBalancesLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.title = nil
    }
    
    // Helper funcs
    
    @objc func accountsList() {
        let vc: AccountsListViewController = AccountsListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addIncomePressed() {
        self.addIncome.layer.backgroundColor = UIColor.lightGray.cgColor
        let vc: TransactionViewController = TransactionViewController()
        vc.income = true
        vc.add = true
        vc.account = array[indexOfMajorCell()]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addExpensePressed() {
        self.addExpense.layer.backgroundColor = UIColor.lightGray.cgColor
        let vc: TransactionViewController = TransactionViewController()
        vc.income = false
        vc.add = true
        vc.account = array[indexOfMajorCell()]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func viewTransactionsPressed() {
        let indexOfMajorCell = self.indexOfMajorCell()
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        let account: NSManagedObject = array[indexPath.row]
        let vc: TransactionsListViewController = TransactionsListViewController()
        vc.account = account
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func transferPressed() {
        self.addTransfer.layer.backgroundColor = UIColor.lightGray.cgColor
        let vc: AddTransferViewController = AddTransferViewController()
        
        vc.fromAccount = array[indexOfMajorCell()]
        if array.count > 1 {
            for n in 0...array.count {
                if n != indexOfMajorCell() {
                    vc.toAccount = array[n]
                    break
                }
            }
        } else {
            vc.toAccount = array[indexOfMajorCell()]
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1.0
        
        //        cell.layer.shadowColor = UIColor.gray.cgColor
        //        cell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        //        cell.layer.shadowOpacity = 0.8
        cell.layer.masksToBounds = false
        
        let item = array[indexPath.row]
        let accountName = item.value(forKey: "name") as! String
        let accountCurrency = item.value(forKey: "currency") as! String
        let accountBalance = item.value(forKey: "balance") as! Double
        cell.accountLabel.text = accountName
        cell.amountLabel.text = accountCurrency + " " + doubleToString(double: accountBalance)
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewTransactions.isHidden = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        viewTransactions.isHidden = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = accountBalancesCV.contentSize.width / CGFloat(accountBalancesCV.numberOfItems(inSection: 0))
        if pageWidth <= 70 { return }
        let page = Int(accountBalancesCV.contentOffset.x / (pageWidth - 70))
        accountBalancesPC.currentPage = page
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let indexOfMajorCell = self.indexOfMajorCell()
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        accountBalancesLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        UserDefaults.standard.set(indexOfMajorCell, forKey: "defaultAccountRow")
    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = accountBalancesLayout.itemSize.width
        let proportionalOffset = accountBalancesLayout.collectionView!.contentOffset.x / itemWidth
        return Int(round(proportionalOffset))
    }
    
}

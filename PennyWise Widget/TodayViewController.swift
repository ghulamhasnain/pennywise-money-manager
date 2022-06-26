////
////  TodayViewController.swift
////  PennyWise Widget
////
////  Created by Ghulam Hasnain on 08/12/2018.
////  Copyright © 2018 Ghulam Hasnain. All rights reserved.
////
//
//import UIKit
//import NotificationCenter
//
//@objc(TodayViewController)
//
//class TodayViewController: UIViewController, NCWidgetProviding {
//
//    var array: [String: String] = [:]
//    var accountsNames: [String] = []
//    private var namesLayout: UICollectionViewFlowLayout!
//    private var namesCV:UICollectionView!
//    private var namesPC:UIPageControl!
//    private var nextNameButton: UIBarButtonItem!
//
//    override func loadView() {
//        super.loadView()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Fetching account info to fill the array
//
//        if let userDefaults = UserDefaults(suiteName: "group.PennyWiseData") {
//            array = userDefaults.dictionary(forKey: "info") as! [String : String]
//            for (name, balance) in array {
//                accountsNames.append(name)
//            }
//        }
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        // MARK: Setting up the views
//
//        /// MARK: Bar button item
//
//        let todayWidget = extensionContext?.widgetMaximumSize(for: .compact)
//        namesLayout = UICollectionViewFlowLayout()
//        namesLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        namesLayout.itemSize = CGSize(width: todayWidget!.width, height: todayWidget!.height)
//        namesLayout.scrollDirection = .horizontal
//
//        namesCV = UICollectionView(frame: CGRect(x: 0, y: 0, width: todayWidget!.width, height: todayWidget!.height), collectionViewLayout: namesLayout)
//        namesCV.dataSource = self
//        namesCV.delegate = self
//        namesCV.register(CustomWidgetCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        namesCV.backgroundColor = UIColor.clear
//        namesCV.isPagingEnabled = true
//        namesCV.showsHorizontalScrollIndicator = false
//        namesCV.showsVerticalScrollIndicator = false
//        view.addSubview(namesCV)
//
//        namesPC = UIPageControl(frame: CGRect(x: 0, y: todayWidget!.height - 12, width: todayWidget!.width, height: 10))
//        namesPC.numberOfPages = array.count
//        namesPC.currentPageIndicatorTintColor = UIColor.black
//        namesPC.pageIndicatorTintColor = UIColor.lightGray
//        view.addSubview(namesPC)
//    }
//
//    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
//        // Perform any setup necessary in order to update the view.
//
//        // If an error is encountered, use NCUpdateResult.Failed
//        // If there's no update required, use NCUpdateResult.NoData
//        // If there's an update, use NCUpdateResult.NewData
//
//        completionHandler(NCUpdateResult.newData)
//    }
//
//}
//
//extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    @objc func rightButtonPressed() {
//        let currentPage = namesPC.currentPage
//        let nextPage = currentPage + 1
//        let indexPath = IndexPath(row: nextPage, section: 0)
//        if nextPage < array.count {
//            namesPC.currentPage = nextPage
//            namesLayout.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
//    }
//
//    @objc func leftButtonPressed() {
//        let currentPage = namesPC.currentPage
//        let previousPage = currentPage - 1
//        let indexPath = IndexPath(row: previousPage, section: 0)
//        if previousPage >= 0 {
//            namesPC.currentPage = previousPage
//            namesLayout.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return array.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomWidgetCollectionViewCell
//
//        let todayWidget = extensionContext?.widgetMaximumSize(for: .compact)
//        let accountName = String(accountsNames[indexPath.row])
//
//        cell.accountLabel.text = accountName.components(separatedBy: ". ")[1]
//        cell.accountLabel.frame = CGRect(x: 0, y: 0, width: (todayWidget?.width)!/2, height: (todayWidget?.height)!*2/4)
//
//        cell.amountLabel.text = String(array[accountName] as! String)
//        cell.amountLabel.frame = CGRect(x: cell.accountLabel.frame.maxX, y: 0, width: (todayWidget?.width)!/2, height: (todayWidget?.height)!*2/4)
//
//        cell.leftButton.frame = CGRect(x: 0, y: (todayWidget?.height)!*2/4, width: (todayWidget?.width)!/2, height: (todayWidget?.height)!/4)
//        cell.leftButton.setTitle("⇠", for: .normal)
//        cell.leftButton.addTarget(self, action: #selector(TodayViewController.leftButtonPressed), for: .touchDown)
//
//        cell.rightButton.frame = CGRect(x: (todayWidget?.width)!/2, y: (todayWidget?.height)!*2/4, width: (todayWidget?.width)!/2, height: (todayWidget?.height)!/4)
//        cell.rightButton.setTitle("⇢", for: .normal)
//        cell.rightButton.addTarget(self, action: #selector(TodayViewController.rightButtonPressed), for: .touchDown)
//
//        return cell
//    }
//
//
//}


import UIKit
import NotificationCenter

@objc(TodayViewController)

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var array: [String: String] = [:]
    var accountsNames: [String] = []
    var contentSize = CGFloat()
    private var namesTV:UITableView!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetching account info to fill the array

        if let userDefaults = UserDefaults(suiteName: "group.PennyWiseData") {
            array = userDefaults.dictionary(forKey: "info") as! [String : String]
            for (name, balance) in array {
                accountsNames.append(name)
            }
        }
        contentSize = CGFloat(45 * array.count)
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: Setting up the views
        
        /// MARK: Bar button item
        
        let todayWidget = extensionContext?.widgetMaximumSize(for: .expanded)
        
        namesTV = UITableView(frame: CGRect(x: 0, y: 0, width: todayWidget!.width, height: todayWidget!.height))
        namesTV.dataSource = self
        namesTV.delegate = self
        view.addSubview(namesTV)
        
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: maxSize.width, height: contentSize)
        }
    }
    
    
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        let accountName = String(accountsNames[indexPath.row])
        
        cell.textLabel?.text = accountName.components(separatedBy: ". ")[1]
        cell.textLabel?.font = myNormalFont
        
        cell.detailTextLabel!.text = String(array[accountName] as! String)
        cell.detailTextLabel!.textColor = UIColor.black
        cell.detailTextLabel!.font = myNormalFont
        
        return cell
    }
    
    
}

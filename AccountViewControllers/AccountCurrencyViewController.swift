//
//  AddAccountViewController.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 03/07/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit
import CoreData

class AccountCurrencyViewController: UIViewController {
    
    var currency: String!
    private var pickerView: UIPickerView!
    private var addAccountBarButtonItem: UIBarButtonItem!
    private var addAccountErrorAlert: UIAlertAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor
        
        // MARK: Set up the view
        self.title = "Add Currency"
        
        addAccountBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(AccountCurrencyViewController.saveAccount))
        self.navigationItem.rightBarButtonItem = addAccountBarButtonItem
        
        pickerView = UIPickerView(frame: CGRect(x: view.frame.maxX*0.025, y: view.frame.maxY/5, width: view.frame.width*0.95, height: view.frame.height/3))
        pickerView.layer.borderColor = UIColor.lightGray.cgColor
        pickerView.layer.borderWidth = 1.0
        pickerView.layer.cornerRadius = 10
        pickerView.backgroundColor = UIColor.white
        pickerView.becomeFirstResponder()
        pickerView.dataSource = self
        pickerView.delegate = self
        view.addSubview(pickerView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pickerView.selectRow(Array(listOfCurrenciesDetail.keys).sorted().firstIndex(of: currency)!, inComponent: 0, animated: true)
    }
    
    // MARK: Helper funcs
    
    @objc func saveAccount() {
        let location = navigationController?.viewControllers.index(before: (navigationController?.viewControllers.count)!-1)
        let nav = navigationController?.viewControllers[location!]
        let vc = nav as! AccountViewController
        vc.currency = currency
        navigationController?.popToViewController(vc, animated: true)
    }
    
}

extension AccountCurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfCurrenciesDetail.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let curr = Array(listOfCurrenciesDetail.keys).sorted()[row]
        return curr + " - " + listOfCurrenciesDetail[curr]!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.selectRow(row, inComponent: component, animated: true)
        currency = Array(listOfCurrenciesDetail.keys).sorted()[row]
    }
    
}

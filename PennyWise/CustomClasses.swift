//
//  CustomClasses.swift
//  PennyWise
//
//  Created by Ghulam Hasnain on 30/06/2018.
//  Copyright © 2018 Ghulam Hasnain. All rights reserved.
//

import UIKit

//let myColor: UIColor! = UIColor(red: 230/255, green: 230/255, blue: 255/255, alpha: 1.0)
let myColor: UIColor! = UIColor(red: 255/255, green: 226/255, blue: 91/255, alpha: 1)
let myAltColor: UIColor! = UIColor(red: 255/255, green: 240/255, blue: 168/255, alpha: 1)
let myGreen: UIColor! = UIColor(red: 181/255, green: 231/255, blue: 160/255, alpha: 1)
let myAltGreen: UIColor! = UIColor(red: 214/255, green: 231/255, blue: 206/255, alpha: 1.0)
let myRed: UIColor! = UIColor(red: 231/255, green: 160/255, blue: 181/255, alpha: 1)
let myAltRed: UIColor! = UIColor(red: 231/255, green: 206/255, blue: 214/255, alpha: 1.0)
let myGrey: UIColor! = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)

let myLargeFont: UIFont! = UIFont(name: "HelveticaNeue-Light", size: 24)
let myVeryLargeFont: UIFont! = UIFont(name: "HelveticaNeue-Light", size: 28)
let myNormalFont: UIFont! = UIFont(name: "HelveticaNeue-Light", size: 18)
let mySmallFont: UIFont! = UIFont(name: "HelveticaNeue-Light", size: 14)

let transferAccountName = "Transfer00Fr0m&2Acc0unts"

let listOfCurrenciesDetail = ["AED": "United Arab Emirates Dirham", "AFN": "Afghan Afghani", "ALL": "Albanian Lek", "AMD": "Armenian Dram", "ANG": "Netherlands Antillean Guilder", "AOA": "Angolan Kwanza", "ARS": "Argentine Peso", "AUD": "Australian Dollar", "AWG": "Aruban Florin", "AZN": "Azerbaijani Manat", "BAM": "Bosnia-Herzegovina Convertible Mark", "BBD": "Barbadian Dollar", "BDT": "Bangladeshi Taka", "BGN": "Bulgarian Lev", "BHD": "Bahraini Dinar", "BIF": "Burundian Franc", "BMD": "Bermudan Dollar", "BND": "Brunei Dollar", "BOB": "Bolivian Boliviano", "BRL": "Brazilian Real", "BSD": "Bahamian Dollar", "BTC": "Bitcoin", "BTN": "Bhutanese Ngultrum", "BWP": "Botswanan Pula", "BYN": "Belarusian Ruble", "BZD": "Belize Dollar", "CAD": "Canadian Dollar", "CDF": "Congolese Franc", "CHF": "Swiss Franc", "CLF": "Chilean Unit of Account (UF)", "CLP": "Chilean Peso", "CNH": "Chinese Yuan (Offshore)", "CNY": "Chinese Yuan", "COP": "Colombian Peso", "CRC": "Costa Rican Colón", "CUC": "Cuban Convertible Peso", "CUP": "Cuban Peso", "CVE": "Cape Verdean Escudo", "CZK": "Czech Republic Koruna", "DJF": "Djiboutian Franc", "DKK": "Danish Krone", "DOP": "Dominican Peso", "DZD": "Algerian Dinar", "EGP": "Egyptian Pound", "ERN": "Eritrean Nakfa", "ETB": "Ethiopian Birr", "EUR": "Euro", "FJD": "Fijian Dollar", "FKP": "Falkland Islands Pound", "GBP": "British Pound Sterling", "GEL": "Georgian Lari", "GGP": "Guernsey Pound", "GHS": "Ghanaian Cedi", "GIP": "Gibraltar Pound", "GMD": "Gambian Dalasi", "GNF": "Guinean Franc", "GTQ": "Guatemalan Quetzal", "GYD": "Guyanaese Dollar", "HKD": "Hong Kong Dollar", "HNL": "Honduran Lempira", "HRK": "Croatian Kuna", "HTG": "Haitian Gourde", "HUF": "Hungarian Forint", "IDR": "Indonesian Rupiah", "ILS": "Israeli New Sheqel", "IMP": "Manx pound", "INR": "Indian Rupee", "IQD": "Iraqi Dinar", "IRR": "Iranian Rial", "ISK": "Icelandic Króna", "JEP": "Jersey Pound", "JMD": "Jamaican Dollar", "JOD": "Jordanian Dinar", "JPY": "Japanese Yen", "KES": "Kenyan Shilling", "KGS": "Kyrgystani Som", "KHR": "Cambodian Riel", "KMF": "Comorian Franc", "KPW": "North Korean Won", "KRW": "South Korean Won", "KWD": "Kuwaiti Dinar", "KYD": "Cayman Islands Dollar", "KZT": "Kazakhstani Tenge", "LAK": "Laotian Kip", "LBP": "Lebanese Pound", "LKR": "Sri Lankan Rupee", "LRD": "Liberian Dollar", "LSL": "Lesotho Loti", "LYD": "Libyan Dinar", "MAD": "Moroccan Dirham", "MDL": "Moldovan Leu", "MGA": "Malagasy Ariary", "MKD": "Macedonian Denar", "MMK": "Myanma Kyat", "MNT": "Mongolian Tugrik", "MOP": "Macanese Pataca", "MRO": "Mauritanian Ouguiya (pre-2018)", "MRU": "Mauritanian Ouguiya", "MUR": "Mauritian Rupee", "MVR": "Maldivian Rufiyaa", "MWK": "Malawian Kwacha", "MXN": "Mexican Peso", "MYR": "Malaysian Ringgit", "MZN": "Mozambican Metical", "NAD": "Namibian Dollar", "NGN": "Nigerian Naira", "NIO": "Nicaraguan Córdoba", "NOK": "Norwegian Krone", "NPR": "Nepalese Rupee", "NZD": "New Zealand Dollar", "OMR": "Omani Rial", "PAB": "Panamanian Balboa", "PEN": "Peruvian Nuevo Sol", "PGK": "Papua New Guinean Kina", "PHP": "Philippine Peso", "PKR": "Pakistani Rupee", "PLN": "Polish Zloty", "PYG": "Paraguayan Guarani", "QAR": "Qatari Rial", "RON": "Romanian Leu", "RSD": "Serbian Dinar", "RUB": "Russian Ruble", "RWF": "Rwandan Franc", "SAR": "Saudi Riyal", "SBD": "Solomon Islands Dollar", "SCR": "Seychellois Rupee", "SDG": "Sudanese Pound", "SEK": "Swedish Krona", "SGD": "Singapore Dollar", "SHP": "Saint Helena Pound", "SLL": "Sierra Leonean Leone", "SOS": "Somali Shilling", "SRD": "Surinamese Dollar", "SSP": "South Sudanese Pound", "STD": "São Tomé and Príncipe Dobra (pre-2018)", "STN": "São Tomé and Príncipe Dobra", "SVC": "Salvadoran Colón", "SYP": "Syrian Pound", "SZL": "Swazi Lilangeni", "THB": "Thai Baht", "TJS": "Tajikistani Somoni", "TMT": "Turkmenistani Manat", "TND": "Tunisian Dinar", "TOP": "Tongan Pa'anga", "TRY": "Turkish Lira", "TTD": "Trinidad and Tobago Dollar", "TWD": "New Taiwan Dollar", "TZS": "Tanzanian Shilling", "UAH": "Ukrainian Hryvnia", "UGX": "Ugandan Shilling", "USD": "United States Dollar", "UYU": "Uruguayan Peso", "UZS": "Uzbekistan Som", "VEF": "Venezuelan Bolívar Fuerte (Old)", "VES": "Venezuelan Bolívar Soberano", "VND": "Vietnamese Dong", "VUV": "Vanuatu Vatu", "WST": "Samoan Tala", "XAF": "CFA Franc BEAC", "XAG": "Silver Ounce", "XAU": "Gold Ounce", "XCD": "East Caribbean Dollar", "XDR": "Special Drawing Rights", "XOF": "CFA Franc BCEAO", "XPD": "Palladium Ounce", "XPF": "CFP Franc", "XPT": "Platinum Ounce", "YER": "Yemeni Rial", "ZAR": "South African Rand", "ZMW": "Zambian Kwacha", "ZWL": "Zimbabwean Dollar"]

class CustomMainButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 40)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.layer.masksToBounds = false
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}

class CustomMainButtonLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = .center
        self.font = mySmallFont
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    var accountLabel: UILabel! = {
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.94, height: UIScreen.main.bounds.height/9))
        view.font = myNormalFont
        view.textAlignment = .center
        return view
    }()
    
    var amountLabel: UILabel! = {
        let view = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/9, width: UIScreen.main.bounds.width * 0.94, height: 40))
        view.font = myVeryLargeFont
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.accountLabel)
        self.addSubview(self.amountLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class CustomDateVC: UIViewController {
    
    var date: Date!
    var datePicker: UIDatePicker!
    var doneBarButtonItem: UIBarButtonItem!
    var navigationBarHeight: CGFloat!
    
    required init(date: Date) {
        super.init(nibName: nil, bundle: nil)
        
        doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.donePressed))
        navigationItem.rightBarButtonItem = doneBarButtonItem
        
        navigationBarHeight = 88
        
        datePicker = UIDatePicker(frame: CGRect(x: view.frame.maxX*0.025, y: navigationBarHeight + 25, width: view.frame.width*0.95, height: view.frame.height/5))
        datePicker.setDate(date, animated: true)
        datePicker.datePickerMode = .date
        datePicker.layer.cornerRadius = 10
        datePicker.layer.borderColor = UIColor.lightGray.cgColor
        datePicker.layer.borderWidth = 1.0
        datePicker.layer.backgroundColor = UIColor.white.cgColor
        view.addSubview(datePicker)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func donePressed() {
        print("ok")
    }
    
}

class CustomCommentVC: UIViewController {
    
    var comment: String!
    var commentTextView: UITextView!
    var doneBarButtonItem: UIBarButtonItem!
    var navigationBarHeight: CGFloat!
    
    required init(comment: String) {
        super.init(nibName: nil, bundle: nil)
        
        navigationBarHeight = 88
        
        commentTextView = UITextView(frame: CGRect(x: view.frame.maxX*0.025, y: navigationBarHeight + 25, width: view.frame.width*0.95, height: view.frame.height/5))
        commentTextView.layer.cornerRadius = 10
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
        commentTextView.layer.borderWidth = 1.0
        commentTextView.text = comment
        commentTextView.textColor = UIColor.gray
        commentTextView.font = UIFont.systemFont(ofSize: 15)
        commentTextView.becomeFirstResponder()
        view.addSubview(commentTextView)
        
        self.doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.donePressed))
        navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func donePressed() {
        print("done pressed")
    }
    
    
}

class CustomCalculatorVC: UIViewController {
    
    var amount: Double!
    var openingBalance: Double!
    var navigationBarHeight: CGFloat!
    var goBackToViewController: UIViewController!
    var buttonColor: UIColor!
    var amountLabel: UILabel!
    
    var dummyButton: UIButton!
    var num0: UIButton!
    var num1: UIButton!
    var num2: UIButton!
    var num3: UIButton!
    var num4: UIButton!
    var num5: UIButton!
    var num6: UIButton!
    var num7: UIButton!
    var num8: UIButton!
    var num9: UIButton!
    var delete: calcButton!
    var decimal: UIButton!
    var doneBarButtonItem: UIBarButtonItem!
    var altColor: UIColor!
    var lastButtonPressed: String!
    
    var decimalPressed: Bool = false
    
    required init(amount: Double) {
        
        super.init(nibName: nil, bundle: nil)
        
        // Amount label setup
        navigationBarHeight = 88
        
        amountLabel = UILabel(frame: CGRect(x: view.frame.maxX*0.025, y: navigationBarHeight + 25, width: view.frame.width*0.95, height: view.frame.height/5))
        amountLabel.layer.cornerRadius = 10
        amountLabel.text = (amount != nil) ? doubleToString(double: amount) : "0"
        amountLabel.layer.borderColor = UIColor.gray.cgColor
        amountLabel.layer.borderWidth = 1.0
        amountLabel.layer.backgroundColor = buttonColor.cgColor
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.systemFont(ofSize: 50)
        view.addSubview(amountLabel)
        
        // Done bar button setup
        
        navigationItem.rightBarButtonItem = doneBarButtonItem
        
        // Buttons setup
        let buttonWidth = view.frame.width*0.95/3 - 6
        let buttonHeight =  (view.frame.height - amountLabel.frame.height - 87 - navigationBarHeight)/5
        
        let buttons = [["7", "8", "9"], ["4", "5", "6"], ["1", "2", "3"], [".", "0", "⇠"]]
        
        var startingX = Double(view.frame.maxX*0.025)
        var startingY = Double(amountLabel.frame.maxY + 25)
        var buttonMaxY = Double(0)
        
        for buttonGroup in buttons {
            for button in buttonGroup {
                let btn = calcButton(x: startingX, y: startingY, w: Double(buttonWidth), h: Double(buttonHeight), buttonText: button, income: false, transfer: false)
                btn.backgroundColor = buttonColor
                btn.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: .touchDown)
                view.addSubview(btn)
                startingX = Double(btn.frame.maxX + 9)
                buttonMaxY = Double(btn.frame.maxY)
            }
            startingY = Double(buttonMaxY + 4)
            startingX = Double(view.frame.maxX*0.025)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func donePressed() {
        print("OK")
    }
    
    @objc func buttonPressed(sender: UIButton) {
        
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = self.altColor
            sender.backgroundColor = self.buttonColor
        }
        
        let num = sender.titleLabel?.text!
        let oldAmount = (amountLabel.text as! String).replacingOccurrences(of: ",", with: "")
        let splitLabel = oldAmount.split(separator: ".")
        if splitLabel.count == 2 {
            decimalPressed = true
        } else {
            decimalPressed = false
        }
        var newAmount: String = ""
        
        switch decimalPressed {
        case true:
            switch num! {
            case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0":
                newAmount = oldAmount + num!
                lastButtonPressed = num!
            case "⇠":
                newAmount = String(oldAmount.dropLast())
            case ".":
                newAmount = oldAmount
            default:
                break
            }
        case false:
            switch lastButtonPressed {
            case nil:
                switch num! {
                case "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    newAmount = num!
                    lastButtonPressed = num!
                case "⇠", "0":
                    newAmount = oldAmount
                case ".":
                    newAmount = oldAmount + num!
                    lastButtonPressed = num!
                default:
                    break
                }
            case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0":
                switch num! {
                case "⇠":
                    newAmount = oldAmount.count != 1 ? String(oldAmount.dropLast()) : "0"
                    if newAmount == "0" {
                        lastButtonPressed = nil
                    }
                case "0":
                    if oldAmount == "0" {
                        newAmount = oldAmount
                    } else {
                        newAmount = oldAmount + num!
                        lastButtonPressed = num!
                    }
                default:
                    newAmount = oldAmount + num!
                    lastButtonPressed = num!
                }
            case ".":
                switch num! {
                case ".":
                    newAmount = oldAmount
                case "⇠":
                    newAmount = oldAmount.count != 1 ? String(oldAmount.dropLast()) : "0"
                    if newAmount == "0" {
                        lastButtonPressed = nil
                    }
                default:
                    newAmount = oldAmount + num!
                    lastButtonPressed = num!
                }
            default:
                print(num!)
            }
        }
        
        //        amountLabel.text = newAmount
        //        amount = Double(newAmount)
        
        let splitNewAmount = newAmount.split(separator: ".")
        if splitNewAmount.count == 1 {
            if newAmount.last == "." {
                amountLabel.text = doubleToString(double: stringToDouble(string: newAmount)) + "."
                amount = Double(newAmount)
            } else {
                amountLabel.text = doubleToString(double: stringToDouble(string: newAmount))
                amount = stringToDouble(string: newAmount)
            }
        } else {
            amountLabel.text = doubleToString(double: stringToDouble(string: String(splitNewAmount[0]))) + "." + String(splitNewAmount[1])
            amount = Double(newAmount)
        }
        
        
    }
    
}

class AddTransactionCollectionViewCell: UICollectionViewCell {
    var label: UILabel! = {
        let view = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX*0.025, y: 0, width: UIScreen.main.bounds.width*0.95, height: UIScreen.main.bounds.height/10))
        view.textAlignment = .left
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class CustomTableViewCell: UITableViewCell {
    
    var leftLabel: UILabel!
    var lowerRightLabel: UILabel!
    var rightLabel: UILabel!
    var categoryLabel: UILabel!
    var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let topLabelsHeight = UIScreen.main.bounds.height/12
        let labelsWidth = UIScreen.main.bounds.width * 0.46
        let bottomLabelsHeight = topLabelsHeight/2
        
        // Date Label setup
        let leftLabelX = UIScreen.main.bounds.maxX * 0.04
        leftLabel = UILabel(frame: CGRect(x: leftLabelX, y: 0, width: labelsWidth, height: topLabelsHeight))
        leftLabel.font = myNormalFont
        contentView.addSubview(leftLabel)
        
        // Amount Label setup
        let rightLabelX = leftLabel.frame.maxX
        rightLabel = UILabel(frame: CGRect(x: rightLabelX, y: 0, width: labelsWidth, height: topLabelsHeight))
        rightLabel.textAlignment = .right
        rightLabel.font = myNormalFont
        rightLabel.textColor = UIColor.black
        contentView.addSubview(rightLabel)
        
        // Comment Label setup
        commentLabel = UILabel(frame: CGRect(x: leftLabelX, y: leftLabel.bounds.maxY, width: labelsWidth, height: bottomLabelsHeight))
        commentLabel.textColor = UIColor.darkGray
        commentLabel.font = mySmallFont
        commentLabel.numberOfLines = 1
        contentView.addSubview(commentLabel)
        
        // Lower right label
        let lowerRightLabelX = commentLabel.frame.maxX
        lowerRightLabel = UILabel(frame: CGRect(x: lowerRightLabelX, y: rightLabel.bounds.maxY, width: labelsWidth, height: bottomLabelsHeight))
        lowerRightLabel.textAlignment = .right
        lowerRightLabel.font = mySmallFont
        lowerRightLabel.textColor = UIColor.darkGray
        contentView.addSubview(lowerRightLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class calcButton: UIButton {
    
    var buttonText: String?
    
    required init(x: Double, y: Double, w: Double, h: Double, buttonText: String, income: Bool, transfer: Bool) {
        super.init(frame: CGRect(x: x, y: y, width: w, height: h))
        setup(buttonText: buttonText, income: income, transfer: transfer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(buttonText: String, income: Bool, transfer: Bool) {
        if transfer {
            self.backgroundColor = UIColor.lightGray
        } else {
            self.backgroundColor = income ? myAltGreen : myAltRed
        }
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10.0
        self.setTitle(buttonText, for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
    
}

struct TransactionInfo {
    var account: String
    var date: Date
    var amount: Double
    var category: String
    var comment: String
}

// Date Formatter

let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .medium
    return df
}()

func dateToString(date: Date) -> String {
    return dateFormatter.string(from: date)
}

func dateToStringForLabel(date: Date) -> String {
    let customFormat = "MMMM YYYY"
    
    let USLocale = Locale(identifier: "en_US")
    let USFormat = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: USLocale)
    
    let formatter = DateFormatter()
    formatter.dateFormat = USFormat
    return formatter.string(from: date)
}

// Decimal Formatter

let decimalFormatter : NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 8
    return formatter
}()

func doubleToString(double: Double) -> String {
    return decimalFormatter.string(for: double)!
}

func stringToDouble(string: String) -> Double {
    let commaRemoved = string.replacingOccurrences(of: ",", with: "")
    do {
        return Double(commaRemoved)!
    } catch {
        print("String being converted isn't a Double")
    }
}

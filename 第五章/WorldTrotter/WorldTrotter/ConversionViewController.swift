//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by chenyf on 16/2/17.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit


class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
//        
//        if let text = textField.text where !text.isEmpty {
//            celsiusLabel.text = textField.text
//        }
//        else {
//            celsiusLabel.text = "???"
//        }
        if let text = textField.text, value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
        
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
//            celsiusLabel.text = "\(value)"
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
       let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {

        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
        let replacementTextHasDecimalSeparator = string.rangeOfString(".")
        
        
        if existingTextHasDecimalSeparator != nil &&
                                    replacementTextHasDecimalSeparator != nil {
               return false
        }
        else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view")
        
       
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 挑战
        // 如果是白天还是夜晚显示不同的背景色
        let date:NSDate = NSDate()
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMddHH"
        let dateString = formatter.stringFromDate(date)
        let ns = (dateString as NSString).substringFromIndex(8)
        
        if Int(ns) > 18 {
             self.view.backgroundColor = UIColor.brownColor()
        } else {
            self.view.backgroundColor = UIColor.darkGrayColor()
        }
    }
    
}
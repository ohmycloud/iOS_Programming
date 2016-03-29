//
//  DatePicker.swift
//  Homepwner
//
//  Created by chenyf on 16/3/17.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

protocol SendMesageDelegate {
    func sendMessage(message: String)
}

class DatePickerViewController: UIViewController {
    var delegate: SendMesageDelegate?
    @IBOutlet var datePicker: UIDatePicker!
 
    override func viewDidLoad() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let maxDate = dateFormatter.dateFromString("2020-12-31")
        let minDate = dateFormatter.dateFromString("2008-01-01")
        datePicker.datePickerMode = .Date
        datePicker.minimumDate    = minDate
        datePicker.maximumDate    = maxDate
        
        
        // 设置默认时间
        datePicker.date = NSDate()
        
        // 设置时区
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        print(datePicker.date)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        if self.delegate != nil {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // 不是 yyyy-mm-dd, 而要使用大写的 MM!
            datePicker.datePickerMode = .Date
            let dateString:String = dateFormatter.stringFromDate(datePicker.date)
            self.delegate?.sendMessage(dateString)
        }
    }
}

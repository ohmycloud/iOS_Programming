//
//  BViewController.swift
//  控制器间反向传值
//
//  Created by chenyf on 16/3/17.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

// 发送消息的协议
protocol SendMessageDelegate {
    func sendValue(message: String)
}

class BViewController: UIViewController, UITextFieldDelegate {
    // 代理给 A 控制器, 是为了把值传给 A, 这儿用协议来进行控制器之间的通信
    var delegate: SendMessageDelegate?
    var tempString:String?
    
    @IBOutlet var bTextField: UITextField!
    @IBOutlet var bTextLabel: UILabel!
    @IBAction func passValueToA(sender: UIButton) {
        if(self.delegate != nil) {
            self.delegate!.sendValue(bTextField.text!)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bTextField.delegate = self
        self.bTextLabel.text = tempString
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}


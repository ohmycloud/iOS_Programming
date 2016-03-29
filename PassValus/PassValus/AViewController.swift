//
//  AViewController.swift
//  控制器间反向传值
//
//  Created by chenyf on 16/3/17.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

class AViewController: UIViewController, UITextFieldDelegate, SendMessageDelegate {
    
    @IBOutlet var aTextField: UITextField!
    @IBOutlet var aTextLabel: UILabel!
    @IBAction func passValueToB(sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
       // 设置控制器为 UITextField 的代理
       aTextField.delegate = self
        
       
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AtoB" {
            // 取得 B 视图控制器
            let bController:BViewController = segue.destinationViewController as! BViewController
            // A 给 B 传值
            bController.tempString = aTextField.text
            bController.delegate   = self // 设置代理
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func sendValue(message: String) {
        self.aTextLabel.text = message
    }
}

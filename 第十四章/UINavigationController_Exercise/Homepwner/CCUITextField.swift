//
//  CCUITextField.swift
//  Homepwner
//
//  Created by chenyf on 16/3/17.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

class CCUITextField: UITextField {
    override func becomeFirstResponder() -> Bool {
        self.borderStyle = .Line
   
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        self.borderStyle = .None
        return true
    }
}

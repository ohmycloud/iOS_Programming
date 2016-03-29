//
//  DetailViewController.swift
//  Homepwner
//
//  Created by chenyf on 16/3/10.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, SendMesageDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    // 计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。
    // 需要在设置一个新值之前或者之后运行代码
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    var tempString:String!
    
    
    // 格式化数据
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        dateLabel.text  = self.tempString ?? dateFormatter.stringFromDate(item.dateCreated)
        
        let key = item.itemKey
        let imageToDisplay = imageStore.imageForKey(key)
        imageView.image = imageToDisplay

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        // "保存" 对 item 的改变
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, value = numberFormatter.numberFromString(valueText) {
            item.valueInDollars = value.integerValue
        } else {
            item.valueInDollars = 0
        }
        dateLabel.text  = self.tempString ?? dateFormatter.stringFromDate(item.dateCreated)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return  true
    }
    
    // 点击视图的任意位置, 注销键盘
    
    @IBAction func dismisskeyBoard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        print("点击了背景")
    }
    
    func sendMessage(message: String) {
        dateLabel.text = message
        self.tempString = message
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let desController = segue.destinationViewController as! DatePickerViewController
        desController.delegate = self
    }
    
    
    @IBAction func takePicture(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        // 如果设备拥有 camera, 则拍照, 否则从相簿中选择照片
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        // 把 image picker 放在屏幕上
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // 从 info 字典中获取选择的 image
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // 在 ImagesStore 中存储 image
        imageStore.setImage(image, forKey: item.itemKey)
        // 把选择的 image 放在 屏幕上的 image view 上
        imageView.image = image
        // 把 image picker 从屏幕上拿掉 - 你必须调用该 dismiss 方法
        dismissViewControllerAnimated(true, completion: nil)
    }
}


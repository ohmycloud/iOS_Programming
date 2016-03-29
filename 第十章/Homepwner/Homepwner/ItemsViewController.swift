//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by chenyf on 16/3/6.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        // 得到状态栏的高度
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top:statusBarHeight, left:0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    @IBAction func addNewItem(sender: AnyObject) {
        
        //  创建一个新的 item 并把它添加到 store 中
        let newItem = itemStore.createItem()
        // 计算出新 item 在数组中的位置
        if let index = itemStore.allItems.indexOf(newItem) {
             // 做一个第（section 0, last row) 的 indexPath
             let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            // 把新的这行插入到 table 中
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        if editing {
            sender.setTitle("Edit", forState: .Normal)
            
            // 关闭编辑模式
            setEditing(false, animated: true)
        }
        else {
            sender.setTitle("Done", forState: .Normal)
            
            // 进入编辑模式
            setEditing(true, animated: true)
        }
    }
    
    // 删除 cell
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let item = itemStore.allItems[indexPath.row] // 要删除的这行
            // 删除之前弹出 ActionSheet 以确认
            let title   = "删除 \(item.name)?"
            let message = "确认要删除该项吗?"
            
            // 创建一个 actionSheet
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            // 添加 action
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "删除", style: .Destructive, handler: {(action) -> Void in
                self.itemStore.removeItem(item)     // 删除 Model 中的该行
                // 还要删除 table view 中的那一行
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            })
            ac.addAction(deleteAction)
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    
    // 移动 cell
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // 更新模型
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    // 实现 UITableViewDataSource 协议
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 创建 UITableViewCell 的一个实例, 使用默认的外观
//        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
}

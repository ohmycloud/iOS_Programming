//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by chenyf on 16/3/6.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore! // lanch 时, itemStore 属性被赋值为 ItemStore()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        // 如果 Selector 的方法中带有参数, 则 action 参数中的字符串要带上冒号!
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewItem:")
 
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    
     func addNewItem(sender: AnyObject) {
        
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
    
    // 控制器跳转, 传输数据
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 如果触发的联线(segue)是 "ShowItem" segue
        if segue.identifier == "ShowItem" {
            // 找出哪一行 cell 被点击
            if let row = tableView.indexPathForSelectedRow?.row {
                // 取到跟该行相关的 item 并传递
                let item = itemStore.allItems[row]
                // 取得目标控制器
                let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.item = item
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 创建 UITableViewCell 的一个实例, 使用默认的外观
//        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        let item = itemStore.allItems[indexPath.row]
        
        // 偏好文本尺寸
        cell.updateLabels()
      
        // 配置自定义的 cell
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        // 设置 valueInDollars 的颜色
        if item.valueInDollars >= 50 {
            cell.valueLabel.textColor = UIColor.greenColor()
        } else {
            cell.valueLabel.textColor = UIColor.redColor()
        }
        cell.nameLabel.textColor = UIColor.brownColor()
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

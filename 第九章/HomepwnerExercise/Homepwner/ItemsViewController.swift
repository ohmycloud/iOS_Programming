//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by chenyf on 16/3/6.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore! // Swift 存储属性必须初始化，确认类型，或者用可选类型
    
    override func viewDidLoad() {
         super.viewDidLoad()
        // 得到状态栏的高度
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top:statusBarHeight, left:0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    // 实现 UITableViewDataSource 协议
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    // 根据 valueInDollars 值的大小, 分别返回两个 section 中的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return itemStore.allItems.filter {$0.valueInDollars >= 50}.count
        case 1:
            return itemStore.allItems.filter {$0.valueInDollars < 50}.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 创建 UITableViewCell 的一个实例, 使用默认的外观
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        //let item = itemStore.allItems[indexPath.row]
        var item: Item!
        
        switch indexPath.section {
        case 0:
            item = itemStore.allItems.filter {$0.valueInDollars >= 50}[indexPath.row]
        case 1:
            item = itemStore.allItems.filter {$0.valueInDollars < 50}[indexPath.row]
        default:
            break
        }
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        // NO more items 尚未实现
        if indexPath.row > (itemStore.allItems.count+1) {
            cell.textLabel?.text = "No more items..."
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "More Than 50"
        } else {
            return "Less Than 50"
        }
    }
    
    // 改变行高
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

}

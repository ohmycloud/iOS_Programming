//
//  ItemStore.swift
//  Homepwner
//
//  Created by chenyf on 16/3/7.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

// ItemStore Model, 存储所有的 Items
class ItemStore {
    var allItems = [Item]()  // 保存所有 Items 的数组
    
    // 初始化函数
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true) // 创建一个 Item, 其成员的值是随机生成的
        allItems.append(newItem)
        return newItem
    }
    
    func overFifty() -> [Item] {
        return allItems.filter {$0.valueInDollars >= 50}
    }
    
    func underFifty() -> [Item] {
        return allItems.filter {$0.valueInDollars < 50}
    }
}

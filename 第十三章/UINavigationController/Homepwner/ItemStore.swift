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
    
    // 初始化函数, 实现了 Add 按钮功能就不再需要
//    init() {
//        for _ in 0..<5 {
//            createItem()
//        }
//    }
    
    // 创建一个新 item
    func createItem() -> Item {
        let newItem = Item(random: true) // 创建一个 Item, 其成员的值是随机生成的
        allItems.append(newItem)
        return newItem
    }
    
    // 删除指定的 item
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    // 移动指定的 item
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return // 什么也不做
        }
        // 得到对要移动的 item 的引用, 以使再插入它
        let movedItem = allItems[fromIndex]
        
        // 从数组中删除这个 item
        allItems.removeAtIndex(fromIndex)
        
        // 在新位置插入这个 item
        allItems.insert(movedItem, atIndex: toIndex)
    }
}

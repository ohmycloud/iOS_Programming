//
//  Item.swift
//  Homepwner
//
//  Created by chenyf on 16/3/6.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: NSDate
    
    // A designated initializer ensures that all properties in the class have a value.
    init(name:String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber   = serialNumber
        self.dateCreated    = NSDate()
        
        // 一旦确保了所有的属性都赋上值了, 就调用父类的指定初始化函数
        super.init()
    }
    
    // 添加一个便利初始化函数以创建一个随机生成的 item
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun  = nouns[Int(idx)]
            
            let randomName  = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            self.init(name:randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
            
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
}



































//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by chenyf on 16/2/21.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("MapViewController loaded its view every time before appear")
    }
}

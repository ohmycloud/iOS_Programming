//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by chenyf on 16/2/21.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var mapView: MKMapView!
    
    override func loadView() {
        // 创建一个 map 视图
        mapView = MKMapView()
        
        // 把 mapView 设置为该视图控制器的 view
        view = mapView
        
        // 添加 segment
        let segmentedControl             = UISegmentedControl(items: ["标准", "混合", "卫星"])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        
        // 添加 target-action 对儿
        segmentedControl.addTarget(self, action: "mapTypeChanged:", forControlEvents: .ValueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        
        
        // 创建约束
        let topConstraint      = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
//        let leadingConstrint   = segmentedControl.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor)
//        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
        let margins = view.layoutMarginsGuide
        let leadingConstrint   = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        // 激活约束
        topConstraint.active      = true
        leadingConstrint.active   = true
        trailingConstraint.active = true
 
    }
    
    // 在 loadView() 方法外面实现 action 方法
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
    case 0:
        mapView.mapType = .Standard
    case 1:
        mapView.mapType = .Hybrid
    case 2:
        mapView.mapType = .Satellite
    default:
        break }
    }

}

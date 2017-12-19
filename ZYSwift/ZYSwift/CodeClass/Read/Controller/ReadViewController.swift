//
//  ReadViewController.swift
//  ZYSwift
//
//  Created by admin on 2017/6/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ReadViewController.openDrawer))
        // Do any additional setup after loading the view.
    }

    
    func openDrawer() {
        print("open drawer view controller")
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.openDrawer()
        
    }
    
    

}

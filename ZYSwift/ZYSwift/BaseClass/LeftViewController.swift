//
//  LeftViewController.swift
//  ZYSwift
//
//  Created by admin on 2017/6/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    var titlesArray = ["Read", "Radio", "Topic", "Product"]
    var tableView: UITableView = UITableView()
    var currentIndex:NSInteger = 0
    var classArrays = ["ReadViewController", "RadioViewController", "TopicViewController", "ProductViewController"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // iridescence
        let layer = CAGradientLayer()
        layer.frame = view.frame
        layer.colors = [UIColor.green.cgColor, UIColor.blue.cgColor]
        view.layer.addSublayer(layer)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 160, width: self.view.frame.size.width, height: self.view.frame.size.height-160), style: UITableViewStyle.plain)
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.backgroundColor = UIColor.clear
        //tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "leftReuse")
        view.addSubview(tableView)
        // default selected
        let selectIndex = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: selectIndex, animated: true, scrollPosition: UITableViewScrollPosition.none)
    }

}

extension LeftViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "leftReuse", for: indexPath)
        var cell = tableView.dequeueReusableCell(withIdentifier: "leftcell")
        if !(cell != nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "leftCell")
        }
        cell?.textLabel?.text = self.titlesArray[indexPath.row]
        cell?.backgroundColor = UIColor.clear
        //cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("the selected row is \(indexPath.row)")
        if currentIndex == indexPath.row {
            return
        }
        self.currentIndex = indexPath.row
        
        let className = self.classArrays[indexPath.row]
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        var naVC = delegate.VCDic[className]
        
        if naVC == nil {
            let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let objClass:AnyObject = NSClassFromString("\(nameSpace).\(className)")!
            let realClass = objClass as! UIViewController.Type
            let vc = realClass.init()
            
            naVC = UINavigationController(rootViewController: vc)
            
            let leftItem = UIBarButtonItem(barButtonSystemItem: .add, target: delegate, action: Selector(("openDrawer")))
            vc.navigationItem.leftBarButtonItem = leftItem
            
            delegate.VCDic[className] = naVC;
            print("create a new viewController")
        }
        delegate.drawerVC.setMainViewController(newVC: naVC as! UIViewController)
        
    }
}










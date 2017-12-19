//
//  DrawerViewController.swift
//  ZYSwift
//
//  Created by admin on 2017/6/12.
//  Copyright © 2017年 竹雨. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {

    var isOpen: Bool = false
    var mainView: UIView = UIView()
    var leftView: UIView = UIView()
    var pan = UIPanGestureRecognizer()
    
    // open method
    func open() {
        print("opend!")
        UIView.animate(withDuration: 0.3, animations: {
            self.leftView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            var mainFrame = self.mainView.frame;
            mainFrame.origin.x = 0.7 * self.view.frame.size.width
            self.mainView.frame = mainFrame
            self.leftView.frame = self.view.frame
        }) { (Bool) in
            self.isOpen = true
        }
    }
    // close method
    func close() {
        print("closed!")
        UIView.animate(withDuration: 0.3, animations: {
            self.leftView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
            self.mainView.frame = self.view.frame
            var leftFrame = self.leftView.frame
            leftFrame.origin.x -= 0.7 * self.view.frame.size.width
            self.leftView.frame = leftFrame
        }) { (Bool) in
            self.isOpen = false
        }
        
        
    }
    
    // gestures
    func panHander() {
        let userPoint = self.pan.translation(in: self.mainView)
        var mainFrame = self.mainView.frame
        mainFrame.origin.x += userPoint.x
        if mainFrame.origin.x >= 0 && mainFrame.origin.x <= 0.7*self.view.frame.size.width {
            self.mainView.frame = mainFrame
            
            let a = mainFrame.origin.x / (0.7 * self.view.frame.size.width)
            self.leftView.transform = CGAffineTransform.init(scaleX: 2-a, y: 2-a)
            
            var leftFrame = self.leftView.frame
            leftFrame.origin.x = mainFrame.origin.x/2 - (0.7*self.view.frame.size.width)/2
            self.leftView.frame = leftFrame
        }
        self.pan .setTranslation(CGPoint.zero, in: self.mainView)
        if self.pan.state == UIGestureRecognizerState.ended {
            if self.mainView.frame.origin.x >= (0.7*self.view.frame.size.width)/2 {
                self.open()
            } else {
                self.close()
            }
        }
    }
    
    
    //rewrite init method
    init(leftVC: LeftViewController, mainVC: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.addChildViewController(leftVC)
        self.addChildViewController(mainVC)
        view.addSubview(leftVC.view)
        view.addSubview(mainVC.view)
        leftView = leftVC.view
        mainView = mainVC.view
        
        self.pan = UIPanGestureRecognizer(target: self, action: #selector(DrawerViewController.panHander))
        self.mainView .addGestureRecognizer(self.pan)
        
        var leftFrame = self.leftView.frame
        leftFrame.origin.x -= 0.7 * self.view.frame.size.width
        self.leftView.frame = leftFrame
        self.leftView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        
        let naVC = mainVC as! UINavigationController
        naVC.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    // change mainViewController
    func setMainViewController(newVC: UIViewController) {
        //
        let naVC: UINavigationController = newVC as! UINavigationController
        naVC.delegate = self
        if !self.childViewControllers.contains(newVC) {
            self.addChildViewController(newVC)
        }
        if newVC.view == self.mainView {
            return
        }
        
        var mainFrame = self.mainView.frame
        mainFrame.origin.y += UIScreen.main.bounds.height
        newVC.view.frame = mainFrame
        mainFrame.origin.y -= UIScreen.main.bounds.height
        view.addSubview(newVC.view)
        
        var goFrame = mainFrame
        goFrame.origin.y -= UIScreen.main.bounds.height
        
        UIView.animate(withDuration: 0.3, animations: {
            newVC.view.frame = mainFrame
            self.mainView.frame = goFrame
            self.leftView.isUserInteractionEnabled = false
        }) { (Bool) in
            self.mainView.removeFromSuperview()
            self.mainView.removeGestureRecognizer(self.pan)
            
            self.mainView = newVC.view
            self.mainView.addGestureRecognizer(self.pan)
            self.leftView.isUserInteractionEnabled = true
            self.close()
        }
    }

}


// UINavigationControllerDelegate
extension DrawerViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if navigationController.childViewControllers[0] == viewController {
            self.mainView.addGestureRecognizer(self.pan)
        } else {
            self.mainView.removeGestureRecognizer(self.pan)
        }
    }
    
    
    
    
    
    
}

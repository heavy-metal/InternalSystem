//
//  CustomNavigationController.swift
//  InternalSystem
//
//  Created by gail on 2018/2/2.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    lazy var tipLabel : UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.gray]
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = UIColor.gray
        
        CustomGestureRecognizer()
         setupTipLabel()
        
        //提示label的动画
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init("showtipLabel"), object: nil, queue: nil) { (info) in
            let dic = info.userInfo as! [String:String]
            
            self.showTipLabel(title: dic["title"]!)
            
            NotificationCenter.default.removeObserver(self)
        }
        
        

        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(directionType:.left ,imageName: "backBtn.png", target: self, action: #selector(BackBtnClick))
        
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    @objc func BackBtnClick() {
        popViewController(animated: true)
    }
    
}
extension CustomNavigationController {
    //提示label
    func setupTipLabel() {
        navigationBar.insertSubview(tipLabel, at: 0)
        tipLabel.frame = CGRect(x: 0, y: 10, width: SCREEN_WIDTH, height: 32)
        tipLabel.backgroundColor = GlobalColor.withAlphaComponent(0.8)
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textAlignment = .center
        tipLabel.isHidden = true
    }
    func showTipLabel(title : String) {
        if self.tipLabel.isHidden == false {return}
        self.tipLabel.alpha = 1
        self.tipLabel.y = 12
        tipLabel.text = title
        self.tipLabel.isHidden = false
        UIView.animate(withDuration: 1.0, animations: {
            self.tipLabel.y = 44
        }) { (_) in
            UIView.animate(withDuration: 1.0, delay: 1.5, options: [], animations: {
                self.tipLabel.alpha = 0
            }, completion: { (_) in
                self.tipLabel.isHidden = true
            })
        }
    }
    //重写popViewController
    override func popViewController(animated: Bool) -> UIViewController? {
        for vc in self.viewControllers {
            if vc.isKind(of: filterVC.self) {
                let VC = vc as! filterVC
                VC.searchController.isActive = false
            }
            if vc.isKind(of: SearchRequestVC.self) {
                let VC = vc as! SearchRequestVC
                VC.searchController.isActive = false
            }
            
        }
        return super.popViewController(animated: animated)
    }

}
// MARK: - 全屏手势
extension CustomNavigationController {
    fileprivate func CustomGestureRecognizer() {
        
        let target = interactivePopGestureRecognizer?.delegate
        
        let pan : UIPanGestureRecognizer = UIPanGestureRecognizer(target: target!, action: Selector(("handleNavigationTransition:")))
        
        pan.delegate = self as UIGestureRecognizerDelegate
        self.interactivePopGestureRecognizer?.isEnabled = false
        self.view.addGestureRecognizer(pan)
        
        
    }
}

// MARK: - 是否触发手势
extension CustomNavigationController:UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        if (viewControllers.last?.isKind(of: CZJWebViewController.self))!{
//            return false
//        }
        return viewControllers.count > 1
        
    }

}

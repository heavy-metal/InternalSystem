//
//  CustomTabBarController.swift
//  InternalSystem
//
//  Created by gail on 2018/2/2.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    lazy var salseViewControllor = SalseViewControllor()
    
    lazy var sideMenuVC:RESideMenu! = {
        let sideMenuVC = RESideMenu(contentViewController: CustomNavigationController(rootViewController: salseViewControllor), leftMenuViewController: LeftMenuViewController(), rightMenuViewController: nil)
        sideMenuVC?.tabBarItem.title = "销售"
        sideMenuVC?.tabBarItem.image = UIImage(named:"home.png")
        sideMenuVC?.tabBarItem.selectedImage = UIImage(named:"home_select.png")
        sideMenuVC?.backgroundImage = UIImage(named:"Stars")
        sideMenuVC?.scaleContentView = true
        return sideMenuVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addAllChildsControllors()
        
    }

    
}
extension CustomTabBarController {
    fileprivate func addAllChildsControllors() {
        
        
        addChildViewController(sideMenuVC!)
        
        
        addChildVC(childVC: PurchaseViewController(), title:"采购", image:UIImage(named:"purchase.png"), selectedImage:UIImage(named: "purchase_select.png") )
        
        addChildVC(childVC: StockViewController(), title:"库存", image:UIImage(named:"stock.png"), selectedImage:UIImage(named: "stock_select.png") )
        
        addChildVC(childVC: InstallationViewControllor(), title:"安装", image:UIImage(named:"installation.png"), selectedImage:UIImage(named: "installation_select.png") )
        
        addChildVC(childVC: FinanceViewController(), title:"财务", image:UIImage(named:"Finance.png"), selectedImage:UIImage(named: "Finance_select.png") )
        
    }
    private func addChildVC(childVC:UIViewController,title:String,image:UIImage?,selectedImage:UIImage?) {
        childVC.tabBarItem.title = title
        childVC.tabBarItem.image = image
        childVC.tabBarItem.selectedImage = selectedImage
        let navVC = CustomNavigationController(rootViewController: childVC)
        addChildViewController(navVC)
    }
}


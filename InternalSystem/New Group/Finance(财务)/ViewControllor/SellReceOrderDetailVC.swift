//
//  SellReceOrderDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class SellReceOrderDetailVC: ZJPageMenu {

    var sellModel : SearchSellModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let salsesDetailVc = SalsesDetailVC()
        salsesDetailVc.title = "收款单详情"
        self.addChildViewController(salsesDetailVc)
        salsesDetailVc.sellModel = sellModel
        salsesDetailVc.detailType = .SellReceOrderDetail
        
        let receDetailVC = ReceDetailVC()
        receDetailVC.title = "明细"
        self.addChildViewController(receDetailVC)
        receDetailVC.model = sellModel
        receDetailVC.detailType = .ReceDetail
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
  
}

//
//  InstallationDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class InstallationDetailVC: ZJPageMenu {
    var installModel:InstallModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let salsesDetailVc = SalsesDetailVC()
        salsesDetailVc.title = "安装单详情"
        self.addChildViewController(salsesDetailVc)
        salsesDetailVc.installModel = installModel
        salsesDetailVc.detailType = .installDetail
        
        let productDetailVC = ProductDetailVC()
        productDetailVC.title = "产品明细"
        self.addChildViewController(productDetailVC)
        productDetailVC.installModel = installModel
        productDetailVC.productType = .installOrder
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

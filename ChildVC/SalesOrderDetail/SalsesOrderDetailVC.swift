//
//  SalsesOrderDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/2.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class SalsesOrderDetailVC: ZJPageMenu {
    
    var salsesModel : SalesOrderModel?
    var salsesFormModel : SalesFormModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let salsesDetailVc = SalsesDetailVC()
        salsesDetailVc.title = "销售单详情"
        self.addChildViewController(salsesDetailVc)
        salsesDetailVc.model = salsesModel
        salsesDetailVc.detailType = .salsesDetail
        
        let productDetailVC = ProductDetailVC()
        productDetailVC.title = "产品明细"
        self.addChildViewController(productDetailVC)
        productDetailVC.model = salsesModel
        productDetailVC.productType = .salsesOrder
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


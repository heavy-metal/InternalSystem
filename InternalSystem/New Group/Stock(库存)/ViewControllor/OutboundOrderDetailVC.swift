//
//  OutboundOrderDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/15.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class OutboundOrderDetailVC: ZJPageMenu {
    var outBoundModel : OutboundModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let salsesDetailVc = SalsesDetailVC()
        salsesDetailVc.title = "出库单详情"
        self.addChildViewController(salsesDetailVc)
        salsesDetailVc.outboundModel = outBoundModel
        salsesDetailVc.detailType = .OutboundOrder
        
        let productDetailVC = ProductDetailVC()
        productDetailVC.title = "产品明细"
        self.addChildViewController(productDetailVC)
        productDetailVC.outBoundModel = outBoundModel
        productDetailVC.productType = .OutboundOrder
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

//
//  BuyFormDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/9.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class BuyFormDetailVC: ZJPageMenu {
    var buyModel : BuyModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let salsesDetailVc = SalsesDetailVC()
        salsesDetailVc.title = "进货单详情"
        self.addChildViewController(salsesDetailVc)
        salsesDetailVc.buyModel = buyModel
        salsesDetailVc.detailType = .buyFormDetail
        
        let productDetailVC = ProductDetailVC()
        productDetailVC.title = "产品明细"
        self.addChildViewController(productDetailVC)
        productDetailVC.buyModel = buyModel
        productDetailVC.productType = .buyForm
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

//
//  ReceiptOrderDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/14.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class ReceiptOrderDetailVC: ZJPageMenu {
    
    var receiptModel : ReceiptModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let salsesDetailVc = SalsesDetailVC()
        salsesDetailVc.title = "入库单详情"
        self.addChildViewController(salsesDetailVc)
        salsesDetailVc.receiptModel = receiptModel
        salsesDetailVc.detailType = .receiptOrder
        
        let productDetailVC = ProductDetailVC()
        productDetailVC.title = "产品明细"
        self.addChildViewController(productDetailVC)
        productDetailVC.receiptModel = receiptModel
        productDetailVC.productType = .receiptOrder
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

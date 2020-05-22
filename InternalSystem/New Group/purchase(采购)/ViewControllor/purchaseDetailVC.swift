//
//  purchaseDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/8.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class purchaseDetailVC: ZJPageMenu {
    var purchaseModel : PurchaseModel?
    
    var isPushRemote : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let salsesDetailVc = SalsesDetailVC()
        salsesDetailVc.title = "采购订单详情"
        self.addChildViewController(salsesDetailVc)
        salsesDetailVc.purchaseModel = purchaseModel
        salsesDetailVc.detailType = .purchaseDetail
        
        let productDetailVC = ProductDetailVC()
        productDetailVC.title = "产品明细"
        self.addChildViewController(productDetailVC)
        productDetailVC.purchaseModel = purchaseModel
        productDetailVC.productType = .purchaseForm
        
        if isPushRemote == true {
            isPushRemote = false
            navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "backBtn.png", target: self, action: #selector(PushRemoteAction))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    @objc fileprivate func PushRemoteAction () {
        self.dismiss(animated: true, completion: nil)
    }
}

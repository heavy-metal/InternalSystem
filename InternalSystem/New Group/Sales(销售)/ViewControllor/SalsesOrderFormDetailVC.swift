//
//  SalsesOrderFormDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/6.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class SalsesOrderFormDetailVC: ZJPageMenu {

    var salesFormModel : SalesFormModel?
    
    var isPushRomote : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let salsesDetailVc = SalsesDetailVC()
        salsesDetailVc.title = "销售订单详情"
        self.addChildViewController(salsesDetailVc)
        salsesDetailVc.salesFormModel = salesFormModel
        salsesDetailVc.detailType = .salsesFormDetail
        
        let productDetailVC = ProductDetailVC()
        productDetailVC.title = "产品明细"
        self.addChildViewController(productDetailVC)
        productDetailVC.salesFormModel = salesFormModel
        productDetailVC.productType = .salsesOrderForm
        
        
        if isPushRomote == true {
            isPushRomote = false
            navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "backBtn.png", target: self, action: #selector(PushRomoteAction))
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
    @objc fileprivate func PushRomoteAction () {
        self.dismiss(animated: true, completion: nil)
    }
}

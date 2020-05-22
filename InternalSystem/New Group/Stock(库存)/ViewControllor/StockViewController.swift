//
//  StockViewController.swift
//  InternalSystem
//
//  Created by gail on 2018/2/2.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class StockViewController: ZJPageMenu {
    lazy var setupVCdict = ["CPZL":StockProductInfoVC() ,"CKXX":WarehouseInfoVC() ,"RKDD":ReceiptOrderVC() ,"KCCX":InventoryInquiryVC() ,"CKDD":OutboundOrderVC()]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "库存管理"
        self.view.backgroundColor = UIColor.white
        let info = UserDefaults.standard
        if let codeArray = info.value(forKey: "code2Array") as? [String] {
            
            let titleArray = info.value(forKey: "title2Array") as! [String]
            
            for i in 0..<codeArray.count {
                
                let vc = self.setupVCdict[codeArray[i]]
                vc?.title = titleArray[i]
                self.addChildViewController(vc!)
                
            }
        }
    }

   
}

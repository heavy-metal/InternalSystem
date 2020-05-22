//
//  PurchaseViewController.swift
//  InternalSystem
//
//  Created by gail on 2018/2/2.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class PurchaseViewController: ZJPageMenu {
    
    lazy var setupVCdict = ["GYSXX":SupplierInfoVC() ,"CGDD":PurchaseOrderFormVC() ,"JHDD":IncomingGoodsVC()]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "采购管理"
        self.view.backgroundColor = UIColor.white
        let info = UserDefaults.standard
        if let codeArray = info.value(forKey: "code1Array") as? [String] {
            
            let titleArray = info.value(forKey: "title1Array") as! [String]
            
            for i in 0..<codeArray.count {
                
                let vc = self.setupVCdict[codeArray[i]]
                vc?.title = titleArray[i]
                self.addChildViewController(vc!)
                
            }
        }
        
    }

    }


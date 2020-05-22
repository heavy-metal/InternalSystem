//
//  InstallationViewControllor.swift
//  InternalSystem
//
//  Created by gail on 2018/2/2.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class InstallationViewControllor: ZJPageMenu {
lazy var setupVCdict = ["STXX":EquipmentInfoVC() ,"CLXX":CarInfoVC() ,"AZDG":InstallationSheetVC()]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "安装管理"
        self.view.backgroundColor = UIColor.white
        let info = UserDefaults.standard
        if let codeArray = info.value(forKey: "code3Array") as? [String] {
            
            let titleArray = info.value(forKey: "title3Array") as! [String]
            
            for i in 0..<codeArray.count {
                
                let vc = self.setupVCdict[codeArray[i]]
                vc?.title = titleArray[i]
                self.addChildViewController(vc!)
                
            }
        }
    }

    
}

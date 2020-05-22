//
//  SalseViewControllor.swift
//  InternalSystem
//
//  Created by gail on 2018/2/2.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class SalseViewControllor: ZJPageMenu {
    
    lazy var titleArray = [String]()
    
    lazy var setupVCdict = ["KHXX":ClientInfoVC() ,"XSDA":SalesOrderVC() ,"XSDD":Sales0rderFormVC()]
    
//    lazy var segmentView = SegmentView(frame: CGRect(x: 0, y: CGFloat(NavBarHeight), width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64), controllers: self.childViewControllers, titleArray: self.titleArray, parentC: self)
    
    override func loadView() {
       
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUmToken()
//        GetAppModule()
        setUpUI()
        dealWithCenter()
        
        let info = UserDefaults.standard
        if let codeArray = info.value(forKey: "codeArray") as? [String] {
            
            let titleArray = info.value(forKey: "titleArray") as! [String]
            
            for i in 0..<codeArray.count {
                
                let vc = self.setupVCdict[codeArray[i]]
                vc?.title = titleArray[i]
                self.addChildViewController(vc!)
                
            }
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
extension SalseViewControllor {
    fileprivate func setUpUI () {
        self.title = "销售管理"
        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "leftBtn.png", target: self, action: #selector(presentLeftMenuViewController))
        
    }
    
}
extension SalseViewControllor {
    fileprivate func dealWithCenter() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init("pushVC"), object: nil, queue: nil) { (info) in
            if info.object as! Int  == 3 {
                self.navigationController?.pushViewController(ChangePwdViewController(), animated: true)
            }
        }
    }
   
}

extension SalseViewControllor {
    
    func GetAppModule () {
        HomeNetWorkTool.GetAppModule(parentId: salesModuleID, Success: { (array) in
            
            for model in array {
                self.titleArray.append(model.ModuleName)
                
                let vc = self.setupVCdict[model.ModuleCode]
                vc?.title = model.ModuleName
                self.addChildViewController(vc!)
            }
          
        }) { (error) in
            
        }
    }
    
}
extension SalseViewControllor {
    func UpdateUmToken () {
        let token = UserDefaults.standard.value(forKey: "deviceId")
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            AlamofireTool.getRequest(URLString: UpdateUmTokenUrl, params:["UserId":userInfo["userId"]!,"DeviceType":"3","DeviceToken":token ?? ""], success: { (result) in
                
            }, Failure: { (error) in
                
            })
        }
    }
}

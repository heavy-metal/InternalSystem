//
//  ZJAlertControllerTool.swift
//  InternalSystem
//
//  Created by gail on 2018/2/28.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class ZJAlertControllerTool: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
   class func showAlertSheet(target:UIViewController ,title:String ,titleArray:[String] ,handle:@escaping (_ action:UIAlertAction)->()){
        let alertVC = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        for titleStr in titleArray {
            let action = UIAlertAction(title: titleStr, style: .default, handler: { (action) in
                handle(action)
            })
            alertVC.addAction(action)
        }
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertVC.addAction(cancelBtn)
        target.present(alertVC, animated: true, completion: nil)
    }
}

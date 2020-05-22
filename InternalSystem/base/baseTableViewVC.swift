//
//  baseTableViewVC.swift
//  InternalSystem
//
//  Created by gail on 2018/2/23.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class BaseTableViewVC: UITableViewController {
    
    
    lazy var searchController:UISearchController = {
        var searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "搜索你想要的内容"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false

        searchController.searchBar.setValue("取消", forKey: "_cancelButtonText")
        searchController.searchBar.tintColor = GlobalColor

        if #available(iOS 9.0, *) {
            //此方法仅对9.0之后版本生效 取消按钮的颜色
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = GlobalColor
            
        }
        searchController.searchBar.subviews.first?.subviews.first?.removeFromSuperview()
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension BaseTableViewVC {
    
    func showtipLabel(title:String) {
        
        NotificationCenter.default.post(name: NSNotification.Name.init("showtipLabel"), object: nil, userInfo: ["title":"\(title)"])
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchController.searchBar.resignFirstResponder()
    }
}

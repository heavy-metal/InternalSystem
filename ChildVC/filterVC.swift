//
//  filterVC.swift
//  InternalSystem
//
//  Created by gail on 2018/2/28.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
enum SearchType {
    case salsesOrder
    case salsesOrderForm
    case supplierInfo
}

class filterVC: BaseTableViewVC {
    
    var searchType : SearchType?
    
    lazy var titleArray:[String] = ["起始时间","结束时间","出库状态","转安装状态","是否欠款","是否已作废单据"]
    
    lazy var formTitleArray :[String] = ["起始时间","结束时间","订单状态","是否显示已关闭订单"]
    
    lazy var searchParams:[String:String] = [String:String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "筛选"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(btnClick))
        tableView.separatorStyle = .none
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableHeaderView?.backgroundColor = UIColor.groupTableViewBackground
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        searchController.isActive = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.searchType {
        case .salsesOrder?:
            return titleArray.count
        default:
            return formTitleArray.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "filterCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "filterCell")
            cell?.selectionStyle = .none
            cell?.accessoryType = .disclosureIndicator
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            switch searchType {
            case .salsesOrder?:
                cell?.textLabel?.text = titleArray[indexPath.row]
            default:
                cell?.textLabel?.text = formTitleArray[indexPath.row]
            }
            
            cell?.detailTextLabel?.text = "请选择"
        }
        let lineView = UIView(frame: CGRect(x: 0, y: 44-1, width: SCREEN_WIDTH, height: 1))
        lineView.backgroundColor = UIColor.groupTableViewBackground
        cell?.addSubview(lineView)
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        searchController.searchBar.resignFirstResponder()
        
        let cell = tableView.cellForRow(at: indexPath)
        
        switch indexPath.row {
        case 0,1:
            BRDatePickerView.showDatePicker(withTitle: titleArray[indexPath.row], dateType: .date, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                cell?.detailTextLabel?.text = str
                if indexPath.row == 0 {
                    switch self?.searchType {
                    case .salsesOrder?:
                        self?.searchParams["SellDateBegin"] = str
                    default:
                        self?.searchParams["SaleDateBegin"] = str
                    }
                  
                }else{
                    switch self?.searchType {
                    case .salsesOrder?:
                        self?.searchParams["SellDateEnd"] = str
                    default:
                        self?.searchParams["SaleDateEnd"] = str
                    }
                  
                }
            })
        case 2:
            let array = self.searchType == .salsesOrder ? ["未出库","部分出库","全部出库"] : ["待审核","已审核","部分转销售","全部转销售"]
            BRStringPickerView.showStringPicker(withTitle:titleArray[indexPath.row] , dataSource: array, defaultSelValue: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                cell?.detailTextLabel?.text = str as? String
                let index = array.index(of: str as! String)
                switch self?.searchType {
                case .salsesOrder?:
                    self?.searchParams["OutStockState"] = String(describing: index! + 1)
                default:
                    self?.searchParams["OrderState"] = String(describing: index! + 1)
                }
            })
        case 3:
            let array = self.searchType == .salsesOrder ? ["不需安装","未转安装","部分转安装","全部转安装"] : ["否","是"]
            BRStringPickerView.showStringPicker(withTitle:titleArray[indexPath.row] , dataSource: array, defaultSelValue: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                cell?.detailTextLabel?.text = str as? String
                let index = array.index(of: str as! String)!
                switch self?.searchType {
                case .salsesOrder?:
                    self?.searchParams["ToInstallState"] = String(describing: index)
                default:
                    self?.searchParams["ShowClose"] = String(describing: index)
                }
                
            })
        default:
            let array = ["否","是"]
            BRStringPickerView.showStringPicker(withTitle:titleArray[indexPath.row] , dataSource: array, defaultSelValue: nil, isAutoSelect: true, resultBlock: { [weak self] (str) in
                cell?.detailTextLabel?.text = str as? String
                let index = array.index(of: str as! String)!
                if indexPath.row == 4 {
                    self?.searchParams["HadFee"] = String(describing: index)
                }else{
                    self?.searchParams["ShowDel"] = String(describing: index)
                }
                
            })
        }
        
    }
    @objc fileprivate func btnClick() {
        
        self.searchController.isActive = false
        
        if  !self.searchParams.values.isEmpty {
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.setDefaultAnimationType(.native)
            SVProgressHUD.show()
        }
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.searchType == .salsesOrder ? "searchInfo" : "formSearchInfo"), object: self.searchParams)
    }
}
extension filterVC : UISearchResultsUpdating ,UISearchBarDelegate,UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.count == 0 {return}
        self.searchParams["SearchText"] = searchController.searchBar.text
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.btnClick()
    }
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
    
}


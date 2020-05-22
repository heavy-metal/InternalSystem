//
//  SettlementAccountVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class SettlementAccountVC: BaseTableViewVC {
    var refreshCount = 1
    var searchtext = ""
    lazy var settlementArray = [SettlementModel]()
    lazy var firstSaveArray = [SettlementModel]()
    lazy var remberCurrentPage = 100//记录第一次
    lazy var remberTotalPage = 100
    var page : Page?
    var warehouseModel:WarehouseModel?
    lazy var titleArray = ["账户名称","银行账号","期初余额","当前余额","备注","是否默认账户"]
    lazy var arr = ["否","是"]
    override func viewDidLoad() {
        super.viewDidLoad()

        getData(true)
        setupHeader()
        setupfooter()
        
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = .none
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(named:"delet.png"), for: .bookmark, state: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.dimsBackgroundDuringPresentation = true
    }
}
extension SettlementAccountVC {
    fileprivate func getData(_ firstGet:Bool){
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            let params = ["CurrentPage":"\(refreshCount)","UserId":userInfo["userId"],"SearchText":searchtext]
            FinanceTool.SearchAccount(params: params as? [String : String], Success: { (page, array) in
                self.page = page
                
                if self.remberTotalPage == 100 {self.remberTotalPage = page.TotalPage!}
                if self.remberCurrentPage == 100 {self.remberCurrentPage = page.CurrentPage!}
                
                if firstGet == true {
                    self.settlementArray = array
                    if self.firstSaveArray.count == 0 {self.firstSaveArray = array}
                }else{
                    self.settlementArray.append(contentsOf: array)
                }
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            }, Failure: { (error) in
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            })
        }
        
    }
}
extension SettlementAccountVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return settlementArray.count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 0}
        return 20
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.mj_footer.isHidden = settlementArray.count == 0
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "settlementCELL")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell?.selectionStyle = .none
            
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        }
        let model = settlementArray[indexPath.section]
        cell?.textLabel?.text = titleArray[indexPath.row]
        let infoArray = [model.AccountName,model.BankAccount,"\(model.InitAmt)元","\(model.CurAmt)元",model.Remark,arr[model.IsDefault]]
        cell?.detailTextLabel?.text = infoArray[indexPath.row]
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 1))
        lineView.backgroundColor = UIColor.groupTableViewBackground
        cell?.addSubview(lineView)
        return cell!
    }
    
}
extension SettlementAccountVC {
    fileprivate func setupHeader() {
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.refreshCount = 1
            self?.getData(true)
        })
        tableView.mj_header.beginRefreshing()
    }
    fileprivate func setupfooter() {
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
            if self?.settlementArray.count != 0 {
                self?.refreshCount += 1
            }
            if self?.page?.CurrentPage==self?.page?.TotalPage {
                
                NotificationCenter.default.post(name: NSNotification.Name.init("showtipLabel"), object: nil, userInfo: ["title":"已加载全部"])
                
                
                self?.tableView.mj_footer.endRefreshing()
                
            }else{
                self?.getData(false)
            }
        })
    }
}
extension SettlementAccountVC : UISearchResultsUpdating ,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text?.count == 0 {
            self.searchBarCancelButtonClicked(searchController.searchBar)
            return
        }
        self.searchtext = searchController.searchBar.text ?? ""
        getData(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.contentOffset = CGPoint(x: 0, y: 0)
        self.searchtext = ""
        self.refreshCount = 1
        self.page?.CurrentPage = self.remberCurrentPage
        self.page?.TotalPage = self.remberTotalPage
        
        self.settlementArray = self.firstSaveArray
        self.tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        searchBar.resignFirstResponder()
    }
}

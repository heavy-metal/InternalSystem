//
//  SalesOrderVC.swift
//  InternalSystem
//
//  Created by gail on 2018/2/8.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class SalesOrderVC: BaseTableViewVC {
    
    var refreshCount = 1
    var searchtext = ""
    lazy var salesOrderArray = [SalesOrderModel]()
    lazy var firstSaveArray = [SalesOrderModel]()
    lazy var remberCurrentPage = 100//记录第一次
    lazy var remberTotalPage = 100
    var page : Page?
    lazy var searchParams = [String:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData(true)
        setupHeader()
        setupfooter()
        setUI()
        //筛选搜索返回的info
        NotificationCenter.default.addObserver(forName: NSNotification.Name("searchInfo"), object: nil, queue: nil) { (info) in
            
            guard let info = info.object as? [String:String] else {return}
            if info.values.isEmpty {return}
            self.searchParams = info
            
            self.getData(true)
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension SalesOrderVC {
    fileprivate func setUI() {
        tableView.rowHeight = 100
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ClientInfoCell", bundle: nil), forCellReuseIdentifier: "ClientInfoCell")
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(named:"delet.png"), for: .bookmark, state: .normal)
        self.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar

        
    }
    fileprivate func getData(_ firstGet:Bool){
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            var params = ["CurrentPage":"\(refreshCount)","UserId":userInfo["userId"]]
            //判断values不为空
            if !self.searchParams.values.isEmpty {
            
                for e in self.searchParams {
                    params[e.key] = self.searchParams[e.key]
                }
                
            }
            
            HomeNetWorkTool.SearchSellOrder(params: params as? [String : String], Success: { (page, array) in
                self.page = page
                if self.remberTotalPage == 100 {self.remberTotalPage = page.TotalPage!}
                if self.remberCurrentPage == 100 {self.remberCurrentPage = page.CurrentPage!}
                if firstGet == true {
                    self.salesOrderArray = array
                    if self.firstSaveArray.count == 0 {self.firstSaveArray = array}
                }else{
                    self.salesOrderArray.append(contentsOf: array)
                }
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                SVProgressHUD.dismiss()
            }, Failure: { (error) in
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                SVProgressHUD.showError(withStatus: String(describing: error))
            })
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let salsesOrderDetailVC = SalsesOrderDetailVC()
        salsesOrderDetailVC.salsesModel = salesOrderArray[indexPath.row]
        self.navigationController?.pushViewController(salsesOrderDetailVC, animated: true)
    }
}
extension SalesOrderVC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salesOrderArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientInfoCell", for: indexPath) as! ClientInfoCell
        let model = salesOrderArray[indexPath.row]
        cell.clientNameLabel.text = model.ClientName
        cell.contactLabel.text = model.SellOrderNo
        cell.phoneLabel.text = model.WhName
        cell.collectMoneyLabel.text = model.UnpaidAmt != 0 ? "欠款:\(model.UnpaidAmt!)元" : ""
        
        return cell
    }
}
extension SalesOrderVC {
    fileprivate func setupHeader() {
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.refreshCount = 1
            if self?.searchController.isActive == false {self?.searchParams.removeAll()}
            self?.getData(true)
        })
        tableView.mj_header.beginRefreshing()
    }
    fileprivate func setupfooter() {
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
            if self?.salesOrderArray.count != 0 {
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


extension SalesOrderVC : UISearchResultsUpdating ,UISearchBarDelegate {
    

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let fiterVC = filterVC()
        fiterVC.searchType = .salsesOrder
        self.navigationController?.pushViewController(fiterVC, animated: true)
        
        return true
    }

    func updateSearchResults(for searchController: UISearchController) {
       
        if searchController.searchBar.text == "" {
            return
        }
        self.searchtext = searchController.searchBar.text ?? ""
        getData(true)
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
                self.tableView.contentOffset = CGPoint(x: 0, y: 0)
                self.searchtext = ""
                self.refreshCount = 1
                self.page?.CurrentPage = self.remberCurrentPage
                self.page?.TotalPage = self.remberTotalPage
                self.salesOrderArray = self.firstSaveArray
                self.searchParams.removeAll()
                self.tableView.reloadData()
    }
}

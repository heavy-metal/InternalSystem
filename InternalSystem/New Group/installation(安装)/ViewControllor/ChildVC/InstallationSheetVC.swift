//
//  InstallationSheetVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/15.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class InstallationSheetVC: BaseTableViewVC {
    var refreshCount = 1
    var searchtext = ""
    lazy var installArray = [InstallModel]()
    lazy var firstSaveArray = [InstallModel]()
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
        NotificationCenter.default.addObserver(forName: NSNotification.Name("InstallationSheet"), object: nil, queue: nil) { (info) in
            
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
extension InstallationSheetVC {
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
            StockTool.SearchInstallOrder(params: params as? [String : String], Success: { (page, array) in
                self.page = page
                if self.remberTotalPage == 100 {self.remberTotalPage = page.TotalPage!}
                if self.remberCurrentPage == 100 {self.remberCurrentPage = page.CurrentPage!}
                if firstGet == true {
                    self.installArray = array
                    if self.firstSaveArray.count == 0 {self.firstSaveArray = array}
                }else{
                    self.installArray.append(contentsOf: array)
                }
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                SVProgressHUD.dismiss()
            }, Failure: { (error) in
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            })
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let VC = InstallationDetailVC()
        VC.installModel = installArray[indexPath.row]
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
extension InstallationSheetVC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return installArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientInfoCell", for: indexPath) as! ClientInfoCell
        let model = installArray[indexPath.row]
        cell.clientNameLabel.text = model.ClientName
        cell.contactLabel.text = "联系人:\(model.Contact)"
        cell.phoneLabel.text = "联系电话:\(model.Mobile)"
        cell.collectMoneyLabel.text = ""
        
        return cell
    }
}
extension InstallationSheetVC {
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
            if self?.installArray.count != 0 {
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


extension InstallationSheetVC : UISearchResultsUpdating ,UISearchBarDelegate {
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let searchRequestVC = SearchRequestVC()
        searchRequestVC.purchaseSearchType = .InstallationSheet
        self.navigationController?.pushViewController(searchRequestVC, animated: true)
        
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
        self.installArray = self.firstSaveArray
        self.searchParams.removeAll()
        self.tableView.reloadData()
    }
}

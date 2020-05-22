//
//  ClientInfoVC.swift
//  InternalSystem
//
//  Created by gail on 2018/2/8.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class ClientInfoVC: BaseTableViewVC {
    
    var refreshCount = 1
    var searchtext = ""
    lazy var clientArray = [ClientModel]()
    lazy var firstSaveArray = [ClientModel]()
    lazy var remberCurrentPage = 100//记录第一次
    lazy var remberTotalPage = 100
    var page : Page?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(true)
        setupHeader()
        setupfooter()
        tableView.rowHeight = 100
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ClientInfoCell", bundle: nil), forCellReuseIdentifier: "ClientInfoCell")
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
    }
}
extension ClientInfoVC {
    fileprivate func getData(_ firstGet:Bool){
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            let params = ["CurrentPage":"\(refreshCount)","UserId":userInfo["userId"],"SearchText":searchtext]
            HomeNetWorkTool.SearchClient(params: params as? [String : String], Success: { (page, array) in
                self.page = page
                
                if self.remberTotalPage == 100 {self.remberTotalPage = page.TotalPage!}
                if self.remberCurrentPage == 100 {self.remberCurrentPage = page.CurrentPage!}
                
                if firstGet == true {
                    self.clientArray = array
                    if self.firstSaveArray.count == 0 {self.firstSaveArray = array}
                }else{
                    self.clientArray.append(contentsOf: array)
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
extension ClientInfoVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.mj_footer.isHidden = clientArray.count == 0
        return clientArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientInfoCell", for: indexPath) as! ClientInfoCell
        let model = clientArray[indexPath.row]
        cell.clientNameLabel.text = model.Contact
        cell.contactLabel.text = "联系电话:\(model.Mobile)"
        cell.phoneLabel.text = model.ClientName
        cell.collectMoneyLabel.text = model.ReceAmt != 0 ? "欠款:\(model.ReceAmt!)元" : ""

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailInfoVC()
        vc.clientModel = clientArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
}
extension ClientInfoVC {
    fileprivate func setupHeader() {
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.refreshCount = 1
            self?.getData(true)
        })
        tableView.mj_header.beginRefreshing()
    }
    fileprivate func setupfooter() {
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
            if self?.clientArray.count != 0 {
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
extension ClientInfoVC : UISearchResultsUpdating ,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
    
        if searchController.searchBar.text?.count == 0 {
            self.searchBarCancelButtonClicked(searchController.searchBar)
            return
        }
        self.searchtext = searchController.searchBar.text ?? ""
        getData(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.contentOffset = CGPoint(x: 0, y: 0)
        self.searchtext = ""
        self.refreshCount = 1
        self.page?.CurrentPage = self.remberCurrentPage
        self.page?.TotalPage = self.remberTotalPage
        
        self.clientArray = self.firstSaveArray
        self.tableView.reloadData()
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarCancelButtonClicked(searchBar)
    }
}

//
//  DetailInfoVC.swift
//  InternalSystem
//
//  Created by gail on 2018/2/23.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class DetailInfoVC: BaseTableViewVC {
    
    var clientModel : ClientModel?
    
    lazy var clientTitleArray:[String] = ["联系人","联系电话","客户名","公司名称","客户分类","单位电话","联系人职务","传真","QQ","邮箱","客户备注","地址","初期欠款","应收欠款"]
    
    lazy var clientInfoArray:[String] = [clientModel!.Contact,clientModel!.Mobile,clientModel!.ClientName,clientModel!.CompanyName,clientModel!.ClassName,clientModel!.tel,clientModel!.Position,clientModel!.Fax,clientModel!.QQ,clientModel!.Email,clientModel!.Remark,clientModel!.Address,"\(clientModel!.InitReceAmt ?? 0)元","\(clientModel!.ReceAmt ?? 0)元"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "客户信息详情"
        tableView.separatorStyle = .none
        tableView.rowHeight = 55
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return clientTitleArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "detailCell")

        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "detailCell")
            cell?.selectionStyle = .none
            cell?.accessoryType = .disclosureIndicator
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell?.textLabel?.text = clientTitleArray[indexPath.row]
            cell?.detailTextLabel?.text = clientInfoArray[indexPath.row]
        }
        let lineView = UIView(frame: CGRect(x: 0, y: 50-1, width: SCREEN_WIDTH, height: 1))
        lineView.backgroundColor = UIColor.groupTableViewBackground
        cell?.addSubview(lineView)
        
        return cell!
    }
        
}

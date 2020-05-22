//
//  ReceDetailVC.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
enum OrderDetailType {
    case ReceDetail
    case paymentDetail
}
class ReceDetailVC: BaseTableViewVC {
    var detailType:OrderDetailType?
    var model : SearchSellModel?
    var paymentModel : PaymentModel?
    lazy var titleArray = ["收款类型","销售单编号","业务日期","产品名称","收款项目","备注","收款金额"]
    lazy var receTypeArray = ["销售单收款","其他收款"]
    lazy var receArray = [receDetailModel]()
    
    lazy var paymentTitleArray = ["付款类型","进货单编号","业务日期","产品名称","付款项目","备注","付款金额"]
    lazy var payStateArray = ["进货单付款","其他付款"]
    lazy var payDetailArray = [PayDetailModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        switch self.detailType {
        case .ReceDetail?:
            return receArray.count
        case .paymentDetail?:
            return payDetailArray.count
        default:
            return 0
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.detailType {
        case .ReceDetail?:
            return titleArray.count
        case .paymentDetail?:
            return paymentTitleArray.count
        default:
            return 0
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 5}
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "receCElLL")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell?.selectionStyle = .none
            
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        }
        switch self.detailType {
        case .ReceDetail?:
            let model = receArray[indexPath.section]
            cell?.textLabel?.text = titleArray[indexPath.row]
            let infoArray = [receTypeArray[model.ReceType - 1],model.SellOrderNo,model.SellDate,model.ProdNames,model.OtherProject,model.Remark,"\(model.ReceAmt)元"]
            cell?.detailTextLabel?.text = infoArray[indexPath.row]
        case .paymentDetail?:
            let model = payDetailArray[indexPath.section]
            cell?.textLabel?.text = paymentTitleArray[indexPath.row]
            let infoArray = [payStateArray[model.PayType - 1],model.BuyOrderNo,model.BuyDate,model.ProdNames,model.OtherProject,model.Remark,"\(model.PayAmt)元"]
            cell?.detailTextLabel?.text = infoArray[indexPath.row]
        default:break
        }
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 1))
        lineView.backgroundColor = UIColor.groupTableViewBackground
        cell?.addSubview(lineView)
        return cell!
    }
    

}
extension ReceDetailVC {
    fileprivate func getData() {
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            switch self.detailType {
            case .ReceDetail?:
                FinanceTool.GetSellReceDetail(params: ["UserId":userInfo["userId"]!,"SellReceId":(model?.SellReceId)!], Success: { (array) in
                    self.receArray = array
                    self.tableView.reloadData()
                }, Failure: { (error) in
                    
                })
            case .paymentDetail?:
                FinanceTool.GetBuyPayDetail(params: ["UserId":userInfo["userId"]!,"BuyPayId":(paymentModel?.BuyPayId)!], Success: { (array) in
                    self.payDetailArray = array
                    self.tableView.reloadData()
                }, Failure: { (error) in
                    
                })
            default:break
            }
            
        }
    }
}

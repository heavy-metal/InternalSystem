//
//  FinanceTool.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class FinanceTool: AlamofireTool {
    class func SearchSellRece (params:[String:String]? ,Success:@escaping (Page,[SearchSellModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchSellReceUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = SearchSellReceModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func GetSellReceDetail (params:[String:String]?,Success:@escaping ([receDetailModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: GetSellReceDetailUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = SellReceDetailModel(JSON: result) else {return}
            Success((model.sellModel!.ReceDetailArray)!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func SearchAccount(params:[String:String]? ,Success:@escaping (Page,[SettlementModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchAccountUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = SettlementAccountModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func SearchBuyPay (params:[String:String]? ,Success:@escaping (Page,[PaymentModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchBuyPayUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = PaymentOrderModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func GetBuyPayDetail(params:[String:String]?,Success:@escaping ([PayDetailModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: GetBuyPayDetailUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = BuyPayDetailModel(JSON: result) else {return}
            Success((model.paymentModel?.PayDetailArray)!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
}

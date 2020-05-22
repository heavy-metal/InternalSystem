//
//  PurchaseTool.swift
//  InternalSystem
//
//  Created by gail on 2018/3/6.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class PurchaseTool: AlamofireTool {
    
    class func SearchSupplier (params:[String:String]? ,Success:@escaping (Page,[SupplierModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchSupplierUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
             guard let supplierInfoModel = SupplierInfoModel(JSON: result) else {return}
            Success(supplierInfoModel.Page!,supplierInfoModel.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func SearchPurchOrder (params:[String:String]? ,Success:@escaping (Page,[PurchaseModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: searchPurchOrderUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = PurchaseOrderFormModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func GetPurchOrderDetail (params:[String:String]?,Success:@escaping ([PurchaseProductModel])->() ,Failure:@escaping Failure) {
        
            AlamofireTool.getRequest(URLString: getPurchOrderDetailUrl, params: params, success: { (result) in
                if result["Code"] as! String != "1" {
                    SVProgressHUD.showError(withStatus: result["Message"] as! String)
                    SVProgressHUD.dismiss(withDelay: 2)
                    if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                    return
                }
                SVProgressHUD.dismiss()
                guard let model = PurchaseFormDetailModel(JSON: result) else {return}
                Success((model.purchaseModel?.purchaseProductArray)!)
            }, Failure: { (error) in
                SVProgressHUD.showError(withStatus: error as? String ?? "")
                SVProgressHUD.dismiss(withDelay: 2)
            })
        }
    class func SearchBuyOrder (params:[String:String]? ,Success:@escaping (Page,[BuyModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchBuyOrderUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            SVProgressHUD.dismiss()
            guard let model = BuyOrderModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func GetBuyOrderDetail(params:[String:String]?,Success:@escaping ([BuyDetailModel])->() ,Failure:@escaping Failure){
        AlamofireTool.getRequest(URLString: GetBuyOrderDetailUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            SVProgressHUD.dismiss()
            guard let model = BuyOrderDetailModel(JSON: result) else {return}
            Success((model.buyModel?.buyDetailArray)!)
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
}

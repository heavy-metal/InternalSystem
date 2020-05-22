//
//  StockTool.swift
//  InternalSystem
//
//  Created by gail on 2018/3/12.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class StockTool: AlamofireTool {
    class func SearchProduct (params:[String:String]? ,Success:@escaping (Page,[StockProductModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchProductUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = StockProductInfoModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    
    class func SearchWarehouse(params:[String:String]? ,Success:@escaping (Page,[WarehouseModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchWarehouseUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = StockWarehouseModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func SearchInOrder (params:[String:String]? ,Success:@escaping (Page,[ReceiptModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchInOrderUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = ReceiptOrderModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func GetInOrderDetail (params:[String:String]?,Success:@escaping ([ReceiptDetailModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: GetInOrderDetailUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = ReceiptProductDetailModel(JSON: result) else {return}
            Success((model.receiptModel?.ProductDetailArray!)!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func SearchStock(params:[String:String]? ,Success:@escaping (Page,[InventoryModel])->() ,Failure:@escaping Failure){
        AlamofireTool.getRequest(URLString: SearchStockUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = InventoryInquiryModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func GetStockDetail (params:[String:String]?,Success:@escaping ([InventoryModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: GetStockDetailUrl, params: params, success: { (result) in
            
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = InventoryInquiryDetailModel(JSON: result) else {return}
            Success(model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func SearchOutOrder (params:[String:String]? ,Success:@escaping (Page,[OutboundModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchOutOrderUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = OutboundOrderModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func GetOutOrderDetail (params:[String:String]?,Success:@escaping ([OutboundproductDetailModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: GetOutOrderDetailUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = OutboundDetailModel(JSON: result) else {return}
            Success((model.outboundModel?.productDetailArray!)!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func SearchDevice(params:[String:String]? ,Success:@escaping (Page,[EquipmentModel])->() ,Failure:@escaping Failure){
        AlamofireTool.getRequest(URLString: SearchDeviceUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = EquipmentInfoModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func SearchCar (params:[String:String]? ,Success:@escaping (Page,[CarModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchCarUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = CarInfoModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func SearchInstallOrder (params:[String:String]? ,Success:@escaping (Page,[InstallModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: SearchInstallOrderUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = InstallOrderModel(JSON: result) else {return}
            Success(model.Page!,model.array!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    class func GetInstallOrderDetail (params:[String:String]?,Success:@escaping ([installProductDetailModel])->() ,Failure:@escaping Failure) {
        AlamofireTool.getRequest(URLString: GetInstallOrderDetailUrl, params: params, success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            guard let model = InstallOrdeDetailrModel(JSON: result) else {return}
            Success((model.installModel?.installProductDetailArr)!)
            SVProgressHUD.dismiss()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
}

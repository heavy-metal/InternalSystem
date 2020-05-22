//
//  PurchaseOrderFormModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/8.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class PurchaseOrderFormModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [PurchaseModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class PurchaseModel : Mappable{
    var PurchOrderId = ""
    var PurchOrderNo = ""
    var SupplierId = ""
    var SupplierName = ""
    var PurchDate = ""
    var PurchUser = ""
    var CreateUser = ""
    var CreateDate = ""
    var ProdNames = ""
    var PurchAmt = 0.0
    var TaxAmt = 0.0
    var OtherFee = 0.0
    var TotalAmt = 0.0
    var OrderState = 0
    var Remark = ""
    var IsDel = 0
    var purchaseProductArray : [PurchaseProductModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        PurchOrderId <- map["PurchOrderId"]
        PurchOrderNo <- map["PurchOrderNo"]
        SupplierId <- map["SupplierId"]
        SupplierName <- map["SupplierName"]
        PurchDate <- map["PurchDate"]
        PurchUser <- map["PurchUser"]
        CreateUser <- map["CreateUser"]
        CreateDate <- map["CreateDate"]
        ProdNames <- map["ProdNames"]
        PurchAmt <- map["PurchAmt"]
        TaxAmt <- map["TaxAmt"]
        OtherFee <- map["OtherFee"]
        TotalAmt <- map["TotalAmt"]
        OrderState <- map["OrderState"]
        Remark <- map["Remark"]
        IsDel <- map["IsDel"]
        purchaseProductArray <- map["ProductDetail"]
    }
}
class PurchaseProductModel: Mappable {
    var PurchOrderId = ""
    var ProdId = ""
    var ProdName = ""
    var Model = ""
    var Unit = ""
    var PurchPrice = 0.0
    var PurchCount = 0.0
    var PurchAmt = 0.0
    var TaxRate = 0.0
    var TaxAmt = 0.0
    var AfterTaxAmt = 0.0
    var ToBuyCount = 0.0
    required init?(map: Map){}
    
    func mapping(map: Map){
        PurchOrderId <- map["PurchOrderId"]
        ProdId <- map["ProdId"]
        ProdName <- map["ProdName"]
        Model <- map["Model"]
        Unit <- map["Unit"]
        PurchPrice <- map["PurchPrice"]
        PurchCount <- map["PurchCount"]
        PurchAmt <- map["PurchAmt"]
        TaxRate <- map["TaxRate"]
        PurchAmt <- map["PurchAmt"]
        TaxAmt <- map["TaxAmt"]
        AfterTaxAmt <- map["AfterTaxAmt"]
        ToBuyCount <- map["ToBuyCount"]
    }
}

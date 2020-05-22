//
//  BuyOrderModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/9.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class BuyOrderModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [BuyModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class BuyModel : Mappable {
    var BuyOrderId = ""
    var BuyOrderNo = ""
    var SupplierId = ""
    var SupplierName = ""
    var WhId = ""
    var WhName = ""
    var BuyDate = ""
    var BuyUser = ""
    var CreateUser = ""
    var CreateDate = ""
    var ProdNames = ""
    var BuyAmt = 0.0
    var TaxAmt = 0.0
    var OtherFee = 0.0
    var TotalAmt = 0.0
    var RealPayAmt = 0.0
    var UnpaidAmt = 0.0
    var ToStockState = 0
    var Remark = ""
    var PurchOrderId = ""
    var IsDel = 0
    var buyDetailArray : [BuyDetailModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        BuyOrderId <- map["BuyOrderId"]
        BuyOrderNo <- map["BuyOrderNo"]
        SupplierId <- map["SupplierId"]
        SupplierName <- map["SupplierName"]
        WhId <- map["WhId"]
        WhName <- map["WhName"]
        BuyDate <- map["BuyDate"]
        BuyUser <- map["BuyUser"]
        CreateUser <- map["CreateUser"]
        CreateDate <- map["CreateDate"]
        ProdNames <- map["ProdNames"]
        BuyAmt <- map["BuyAmt"]
        TaxAmt <- map["TaxAmt"]
        OtherFee <- map["OtherFee"]
        TotalAmt <- map["TotalAmt"]
        RealPayAmt <- map["RealPayAmt"]
        UnpaidAmt <- map["UnpaidAmt"]
        ToStockState <- map["ToStockState"]
        Remark <- map["Remark"]
        PurchOrderId <- map["PurchOrderId"]
        IsDel <- map["IsDel"]
        buyDetailArray <- map["ProductDetail"]
    }

}
class BuyDetailModel:Mappable {
    var BuyOrderId = ""
    var ProdId = ""
    var ProdName = ""
    var Model = ""
    var Unit = ""
    var BuyPrice = 0.0
    var BuyCount = 0
    var BuyAmt = 0.0
    var TaxRate = 0.0
    var TaxAmt = 0.0
    var AfterTaxAmt = 0.0
    var ToStockCount = 0
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        BuyOrderId <- map["BuyOrderId"]
        ProdId <- map["ProdId"]
        ProdName <- map["ProdName"]
        Model <- map["Model"]
        Unit <- map["Unit"]
        BuyPrice <- map["BuyPrice"]
        BuyCount <- map["BuyCount"]
        BuyAmt <- map["BuyAmt"]
        TaxRate <- map["TaxRate"]
        TaxAmt <- map["TaxAmt"]
        AfterTaxAmt <- map["AfterTaxAmt"]
        ToStockCount <- map["ToStockCount"]
        
  }
}

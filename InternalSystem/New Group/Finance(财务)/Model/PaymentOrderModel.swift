//
//  PaymentOrderModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class PaymentOrderModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [PaymentModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class PaymentModel: Mappable {
    var BuyPayId = ""
    var BuyPayNo = ""
    var SupplierId = ""
    var SupplierName = ""
    var TotalAmt = 0.0
    var DiscountAmt = 0.0
    var RealPayAmt = 0.0
    var AccountId = ""
    var AccountName = ""
    var PayDate = ""
    var PayUser = ""
    var CreateUser = ""
    var CreateDate = ""
    var Remark = ""
    var IsDel = 0
    var PayDetailArray : [PayDetailModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        BuyPayId <- map["BuyPayId"]
        BuyPayNo <- map["BuyPayNo"]
        SupplierId <- map["SupplierId"]
        SupplierName <- map["SupplierName"]
        TotalAmt <- map["TotalAmt"]
        DiscountAmt <- map["DiscountAmt"]
        RealPayAmt <- map["RealPayAmt"]
        AccountId <- map["AccountId"]
        AccountName <- map["AccountName"]
        PayDate <- map["PayDate"]
        PayUser <- map["PayUser"]
        CreateUser <- map["CreateUser"]
        CreateDate <- map["CreateDate"]
        Remark <- map["Remark"]
        IsDel <- map["IsDel"]
        PayDetailArray <- map["PayDetail"]
    }
}
class PayDetailModel: Mappable {
    var BuyPayId = ""
    var PayType = 0
    var BuyOrderId = ""
    var BuyOrderNo = ""
    var BuyDate = ""
    var ProdNames = ""
    var OtherProject = ""
    var Remark = ""
    var PayAmt = 0.0
   
    required init?(map: Map){}
    
    func mapping(map: Map){
        BuyPayId <- map["BuyPayId"]
        PayType <- map["PayType"]
        BuyOrderId <- map["BuyOrderId"]
        BuyOrderNo <- map["BuyOrderNo"]
        BuyDate <- map["BuyDate"]
        ProdNames <- map["ProdNames"]
        OtherProject <- map["OtherProject"]
        Remark <- map["Remark"]
        PayAmt <- map["PayAmt"]
        
    }
}

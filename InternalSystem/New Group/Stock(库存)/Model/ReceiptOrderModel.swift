//
//  ReceiptOrderModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/14.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class ReceiptOrderModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [ReceiptModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class ReceiptModel : Mappable {
    var InOrderId = ""
    var InOrderNo = ""
    var WhId = ""
    var WhName = ""
    var BusiType = 0
    var ObjId = ""
    var ObjName = ""
    var OrderId = ""
    var OrderNo = ""
    var InDate = ""
    var InUser = ""
    var CreateUser = ""
    var CreateDate = ""
    var ProdNames = ""
    var Remark = ""
    var IsDel = 0
    var ProductDetailArray : [ReceiptDetailModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        InOrderId <- map["InOrderId"]
        InOrderNo <- map["InOrderNo"]
        WhId <- map["WhId"]
        WhName <- map["WhName"]
        BusiType <- map["BusiType"]
        ObjId <- map["ObjId"]
        ObjName <- map["ObjName"]
        OrderId <- map["OrderId"]
        OrderNo <- map["OrderNo"]
        InDate <- map["InDate"]
        InUser <- map["InUser"]
        CreateUser <- map["CreateUser"]
        CreateDate <- map["CreateDate"]
        ProdNames <- map["ProdNames"]
        Remark <- map["Remark"]
        IsDel <- map["IsDel"]
        ProductDetailArray <- map["ProductDetail"]
    }
}
class ReceiptDetailModel : Mappable {
    var InOrderId = ""
    var ProdId = ""
    var ProdName = ""
    var Model = ""
    var Unit = ""
    var InPrice = 0.0
    var InCount = 0.0
    var InAmt = 0.0
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        InOrderId <- map["InOrderId"]
        ProdId <- map["ProdId"]
        ProdName <- map["ProdName"]
        Model <- map["Model"]
        Unit <- map["Unit"]
        InPrice <- map["InPrice"]
        InCount <- map["InCount"]
        InAmt <- map["InAmt"]
    }
}

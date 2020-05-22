//
//  OutboundOrderModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/15.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class OutboundOrderModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [OutboundModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class OutboundModel : Mappable {
    var OutOrderId = ""
    var OutOrderNo = ""
    var WhId = ""
    var WhName = ""
    var BusiType = 0
    var ObjId = ""
    var ObjName = ""
    var OrderId = ""
    var OrderNo = ""
    var OutDate = ""
    var OutUser = ""
    var CreateUser = ""
    var CreateDate = ""
    var ProdNames = ""
    var Remark = ""
    var IsDel = 0
    var productDetailArray : [OutboundproductDetailModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        OutOrderId <- map["OutOrderId"]
        OutOrderNo <- map["OutOrderNo"]
        WhId <- map["WhId"]
        WhName <- map["WhName"]
        BusiType <- map["BusiType"]
        ObjId <- map["ObjId"]
        ObjName <- map["ObjName"]
        OrderId <- map["OrderId"]
        OrderNo <- map["OrderNo"]
        OutDate <- map["OutDate"]
        OutUser <- map["OutUser"]
        CreateUser <- map["CreateUser"]
        CreateDate <- map["CreateDate"]
        ProdNames <- map["ProdNames"]
        Remark <- map["Remark"]
        IsDel <- map["IsDel"]
        productDetailArray <- map["ProductDetail"]
        
    }
}
class OutboundproductDetailModel : Mappable {
    var OutOrderId = ""
    var ProdId = ""
    var ProdName = ""
    var Model = ""
    var Unit = ""
    var OutPrice = 0.0
    var OutCount = 0
    var OutAmt = 0.0
    var CostPrice = 0.0
    
    required init?(map: Map){}
    func mapping(map: Map){
        OutOrderId <- map["OutOrderId"]
        ProdId <- map["ProdId"]
        ProdName <- map["ProdName"]
        Model <- map["Model"]
        Unit <- map["Unit"]
        OutPrice <- map["OutPrice"]
        OutCount <- map["OutCount"]
        OutAmt <- map["OutAmt"]
        CostPrice <- map["CostPrice"]
       
    }
}

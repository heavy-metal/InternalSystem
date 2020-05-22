//
//  Sales0rderFormModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/5.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class Sales0rderFormModel: Mappable {
    var Code = ""
    var message = ""
    var page:Page?
    var array : [SalesFormModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        
        Code <- map["Code"]
        message <- map["Message"]
        page <- map["Page"]
        array <- map["Data"]
    }
}

class SalesFormModel : Mappable {
    
    var SaleOrderId = ""
    var SaleOrderNo = ""
    var ClientId = ""
    var ClientName = ""
    var SaleDate = ""
    var SaleUser = ""
    var CreateUser = ""
    var CreateDate = ""
    var ProdNames = ""
    var SaleAmt = 0.0
    var DiscountAmt = 0.0
    var OtherFee = 0.0
    var TotalAmt = 0.0
    var OrderState = 0
    var Remark = ""
    var IsDel = 0
    var productDetailArray : [ProductFormModel]?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        
        SaleOrderId <- map["SaleOrderId"]
        SaleOrderNo <- map["SaleOrderNo"]
        ClientId <- map["ClientId"]
        ClientName <- map["ClientName"]
        SaleDate <- map["SaleDate"]
        SaleUser <- map["SaleUser"]
        CreateDate <- map["CreateDate"]
        CreateUser <- map["CreateUser"]
        ProdNames <- map["ProdNames"]
        SaleAmt <- map["SaleAmt"]
        DiscountAmt <- map["DiscountAmt"]
        OtherFee <- map["OtherFee"]
        TotalAmt <- map["TotalAmt"]
        OrderState <- map["OrderState"]
        Remark <- map["Remark"]
        IsDel <- map["IsDel"]
        productDetailArray <- map["ProductDetail"]
    }
}
class ProductFormModel: Mappable {
    
    var SaleOrderId = ""
    var ProdId = ""
    var ProdName = ""
    var Model = ""
    var Unit = ""
    var SalePrice = 0
    var SaleCount = 0
    var SaleAmt = 0
    var ToSellCount = 0.0
    
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        
        SaleOrderId <- map["SaleOrderId"]
        ProdId <- map["ProdId"]
        ProdName <- map["ProdName"]
        Model <- map["Model"]
        Unit <- map["Unit"]
        SalePrice <- map["SalePrice"]
        SaleCount <- map["SaleCount"]
        SaleAmt <- map["SaleAmt"]
        ToSellCount <- map["ToSellCount"]
        
        
    }
}

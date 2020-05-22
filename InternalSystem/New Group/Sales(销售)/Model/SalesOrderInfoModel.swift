//
//  SalesOrderInfoModel.swift
//  InternalSystem
//
//  Created by gail on 2018/2/27.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class SalesOrderInfoModel: Mappable {
    var Code = ""
    var message = ""
    var page:Page?
    var array : [SalesOrderModel]?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        page <- map["Page"]
        array <- map["Data"]
        
    }
}
class SalesOrderModel:Mappable{
    
    var SellOrderId : String?
    var SellOrderNo : String?
    var ClientId : String?
    var ClientName : String?
    var WhId : String?
    var WhName : String?
    var SellDate : String?
    var SellUser : String?
    var CreateUser : String?
    var CreateDate : String?
    var ProdNames : String?
    var SellAmt : Float?
    var DiscountAmt : Float?
    var OtherFee : Float?
    var TotalAmt : Float?
    var RealReceAmt : Float?
    var UnpaidAmt : Float?
    var OutStockState : Int?
    var ToInstallState : Int?
    var Remark : String?
    var SaleOrderId : String?
    var IsDel : Int?
    var productArray : [ProductModel]?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        SellOrderId <- map["SellOrderId"]
        SellOrderNo <- map["SellOrderNo"]
        ClientId <- map["ClientId"]
        ClientName <- map["ClientName"]
        WhId <- map["WhId"]
        WhName <- map["WhName"]
        SellDate <- map["SellDate"]
        SellUser <- map["SellUser"]
        CreateUser <- map["CreateUser"]
        CreateDate <- map["CreateDate"]
        ProdNames <- map["ProdNames"]
        SellAmt <- map["SellAmt"]
        DiscountAmt <- map["DiscountAmt"]
        OtherFee <- map["OtherFee"]
        TotalAmt <- map["TotalAmt"]
        RealReceAmt <- map["RealReceAmt"]
        UnpaidAmt <- map["UnpaidAmt"]
        OutStockState <- map["OutStockState"]
        ToInstallState <- map["ToInstallState"]
        Remark <- map["Remark"]
        SaleOrderId <- map["SaleOrderId"]
        IsDel <- map["IsDel"]
        productArray <- map["ProductDetail"]
    }
}
class ProductModel :Mappable {
 
    var SellOrderId = ""
    var ProdId = ""
    var ProdName = ""
    var Model = ""
    var Unit = ""
    var SellPrice = 0
    var SellCount = 0
    var SellAmt = 0
    var CostPrice = 0.0
    var OutStockCount = 0
    var NeedInstall = 0
    var ToInstallCount = 0
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        
        SellOrderId <- map["SellOrderId"]
        ProdId <- map["ProdId"]
        ProdName <- map["ProdName"]
        Model <- map["Model"]
        Unit <- map["Unit"]
        SellPrice <- map["SellPrice"]
        SellCount <- map["SellCount"]
        SellAmt <- map["SellAmt"]
        CostPrice <- map["CostPrice"]
        OutStockCount <- map["OutStockCount"]
        NeedInstall <- map["NeedInstall"]
        ToInstallCount <- map["ToInstallCount"]
        
    }
}

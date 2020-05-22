//
//  SearchSellReceModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class SearchSellReceModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [SearchSellModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class SearchSellModel : Mappable {
    var SellReceId = ""
    var SellReceNo = ""
    var ClientId = ""
    var ClientName = ""
    var TotalAmt = 0.0
    var DiscountAmt = 0.0
    var RealReceAmt = 0.0
    var AccountId = ""
    var AccountName = ""
    var ReceDate = ""
    var ReceUser = ""
    var CreateUser = ""
    var CreateDate = ""
    var Remark = ""
    var IsDel = 0
    var ReceDetailArray : [receDetailModel]?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        SellReceId <- map["SellReceId"]
        SellReceNo <- map["SellReceNo"]
        ClientId <- map["ClientId"]
        ClientName <- map["ClientName"]
        TotalAmt <- map["TotalAmt"]
        DiscountAmt <- map["DiscountAmt"]
        RealReceAmt <- map["RealReceAmt"]
        AccountId <- map["AccountId"]
        AccountName <- map["AccountName"]
        ReceDate <- map["ReceDate"]
        ReceUser <- map["ReceUser"]
        CreateUser <- map["CreateUser"]
        CreateDate <- map["CreateDate"]
        Remark <- map["Remark"]
        IsDel <- map["IsDel"]
        ReceDetailArray <- map["ReceDetail"]
        
    }
}
class receDetailModel: Mappable {
    var SellReceId = ""
    var ReceType = 0
    var SellOrderId = ""
    var SellOrderNo = ""
    var SellDate = ""
    var ProdNames = ""
    var OtherProject = ""
    var Remark = ""
    var ReceAmt = 0.0
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        SellReceId <- map["SellReceId"]
        ReceType <- map["ReceType"]
        SellOrderId <- map["SellOrderId"]
        SellOrderNo <- map["SellOrderNo"]
        SellDate <- map["SellDate"]
        ProdNames <- map["ProdNames"]
        OtherProject <- map["OtherProject"]
        Remark <- map["Remark"]
        ReceAmt <- map["ReceAmt"]
    }
}

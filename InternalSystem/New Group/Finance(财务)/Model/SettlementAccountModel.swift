//
//  SettlementAccountModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/16.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class SettlementAccountModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [SettlementModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class SettlementModel: Mappable {
    var AccountId = ""
    var AccountName = ""
    var BankAccount = ""
    var InitAmt = 0.0
    var CurAmt = 0.0
    var Remark = ""
    var IsDefault = 0
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        AccountId <- map["AccountId"]
        AccountName <- map["AccountName"]
        BankAccount <- map["BankAccount"]
        InitAmt <- map["InitAmt"]
        CurAmt <- map["CurAmt"]
        Remark <- map["Remark"]
        IsDefault <- map["IsDefault"]
        
    }
}

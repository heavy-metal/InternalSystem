//
//  ClientInfoModel.swift
//  InternalSystem
//
//  Created by gail on 2018/2/22.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class ClientInfoModel: Mappable {

    var Code = ""
    var message = ""
    var page:Page?
    var array : [ClientModel]?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        
        Code <- map["Code"]
        message <- map["Message"]
        page <- map["Page"]
        array <- map["Data"]
    }
}
class Page: Mappable {
    var TotalPage : Int?
    var TotalRecord : Int?
    var CurrentPage : Int?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        
        TotalPage <- map["TotalPage"]
        TotalRecord <- map["TotalRecord"]
        CurrentPage <- map["CurrentPage"]
    }
}

class ClientModel: Mappable {
    var ClientId = ""
    var ClientCode = ""
    var ClientName = ""
    var ClassId = ""
    var ClassName = ""
    var CompanyName = ""
    var Contact = ""
    var Position = ""
    var Mobile = ""
    var Fax = ""
    var Email = ""
    var QQ = ""
    var Address = ""
    var Remark = ""
    var InitReceAmt : Int?
    var ReceAmt : Int?
    var tel = ""
    required init?(map: Map){}
    
    func mapping(map: Map){
        
        ClientId <- map["ClientId"]
        ClientCode <- map["ClientCode"]
        ClientName <- map["ClientName"]
        ClassId <- map["ClassId"]
        ClassName <- map["ClassName"]
        CompanyName <- map["CompanyName"]
        Contact <- map["Contact"]
        Position <- map["Position"]
        Mobile <- map["Mobile"]
        Fax <- map["Fax"]
        Email <- map["Email"]
        QQ <- map["QQ"]
        Address <- map["Address"]
        Remark <- map["Remark"]
        InitReceAmt <- map["InitReceAmt"]
        ReceAmt <- map["ReceAmt"]
        tel <- map["Tel"]
    }
}

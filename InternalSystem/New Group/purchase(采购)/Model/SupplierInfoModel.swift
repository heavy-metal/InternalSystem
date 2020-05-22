//
//  SupplierInfoModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/7.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class SupplierInfoModel: Mappable {
    var Code = ""
    var message = ""
    var Page : Page?
    var array : [SupplierModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Page <- map["Page"]
        array <- map["Data"]
    }
}
class SupplierModel : Mappable{
    
    var SupplierId = ""
    var SupplierCode = ""
    var SupplierName = ""
    var ClassId = ""
    var ClassName = ""
    var Tel = ""
    var Contact = ""
    var Position = ""
    var Mobile = ""
    var Fax = ""
    var Email = ""
    var QQ = ""
    var Address = ""
    var Remark = ""
    var InitPayAmt : Int?
    var PayAmt : Int?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        SupplierId <- map["SupplierId"]
        SupplierCode <- map["SupplierCode"]
        SupplierName <- map["SupplierName"]
        ClassId <- map["ClassId"]
        ClassName <- map["ClassName"]
        Tel <- map["Tel"]
        Contact <- map["Contact"]
        Position <- map["Position"]
        Mobile <- map["Mobile"]
        Fax <- map["Fax"]
        Email <- map["Email"]
        QQ <- map["QQ"]
        Address <- map["Address"]
        Remark <- map["Remark"]
        InitPayAmt <- map["InitPayAmt"]
        PayAmt <- map["PayAmt"]
        
    }
}

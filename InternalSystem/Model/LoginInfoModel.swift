//
//  LoginInfoModel.swift
//  InternalSystem
//
//  Created by gail on 2018/2/1.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class LoginInfoModel: Mappable {
    
    var code = ""
    var message = ""
    var loginModel:LoginModel?
    
    
    
    
    required init?(map: Map){}
    
    func mapping(map: Map){
       
        code <- map["Code"]
        message <- map["Message"]
        loginModel <- map["Data"]
    }
}
class LoginModel: Mappable {
    
    var userId:String?
    var userName:String?
    var roleIDs:String?
    var roleNames:String?
    var empName:String?
    var isManager:String?
    var lastTime:String?
    var empImg:String?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        userId <- map["UserId"]
        userName <- map["UserName"]
        roleIDs <- map["RoleIds"]
        roleNames <- map["RoleNames"]
        empName <- map["EmpName"]
        isManager <- map["IsManager"]
        lastTime <- map["LastTime"]
        empImg <- map["EmpImg"]
    }
}

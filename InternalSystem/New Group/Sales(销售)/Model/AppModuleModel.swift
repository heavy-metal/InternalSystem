//
//  AppModuleModel.swift
//  InternalSystem
//
//  Created by gail on 2018/2/7.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class AppModuleModel: Mappable {

    var Code = ""
    var Message = ""
    var Data : [ModuleModel]?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        Message <- map["Message"]
        Data <- map["Data"]
    }
}
class ModuleModel: Mappable {
    
    var ModuleId = ""
    var ModuleCode = ""
    var ModuleName = ""
    var ModuleIcon = ""
    
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        ModuleId <- map["ModuleId"]
        ModuleCode <- map["ModuleCode"]
        ModuleName <- map["ModuleName"]
        ModuleIcon <- map["ModuleIcon"]
    }
}

//
//  PurchaseFormDetailModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/8.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class PurchaseFormDetailModel: Mappable {
    var Code = ""
    var message = ""
    var purchaseModel : PurchaseModel?
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        purchaseModel <- map["Data"]
    }
}

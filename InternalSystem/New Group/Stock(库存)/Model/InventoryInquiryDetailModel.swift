//
//  InventoryInquiryDetailModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/14.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class InventoryInquiryDetailModel: Mappable {
    var Code = ""
    var message = ""
    var array : [InventoryModel]?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        array <- map["Data"]
    }
}

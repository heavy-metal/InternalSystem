//
//  Sales0rderFormDetailModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/6.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class Sales0rderFormDetailModel: Mappable {

    var Code = ""
    var message = ""
    var Data : SalesFormModel?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        Data <- map["Data"]
    }
}

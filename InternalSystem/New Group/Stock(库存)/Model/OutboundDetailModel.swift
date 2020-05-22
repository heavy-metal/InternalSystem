//
//  OutboundDetailModel.swift
//  InternalSystem
//
//  Created by gail on 2018/3/15.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit
import ObjectMapper
class OutboundDetailModel: Mappable {
    var Code = ""
    var message = ""
    var outboundModel : OutboundModel?
    required init?(map: Map){}
    
    func mapping(map: Map){
        Code <- map["Code"]
        message <- map["Message"]
        outboundModel <- map["Data"]
    }
}

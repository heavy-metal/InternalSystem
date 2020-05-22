//
//  PushNotification.swift
//  InternalSystem
//
//  Created by gail on 2018/4/4.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class PushNotification: AppDelegate {
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        //集成友盟推送
        UMConfigure.initWithAppkey("5ac2ec7b8f4a9d59a1000045", channel: "App Store")
        UMConfigure.setLogEnabled(true)
        
        let entity = UMessageRegisterEntity()
        entity.types = Int(UInt8(UMessageAuthorizationOptions.badge.rawValue) | UInt8(UMessageAuthorizationOptions.alert.rawValue) | UInt8(UMessageAuthorizationOptions.sound.rawValue))
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {}
        UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity) { (granted, error) in
            if granted == true {
                // 用户选择了接收Push消息
            }else{
                
            }
            print(granted)
            
        }
        return true
    }
}
extension PushNotification : UNUserNotificationCenterDelegate {
    
}

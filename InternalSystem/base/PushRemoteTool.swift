//
//  PushRemoteTool.swift
//  InternalSystem
//
//  Created by gail on 2018/4/20.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class PushRemoteTool: NSObject {
    var umUserInfo: [AnyHashable : Any]?
    
    lazy var alert1 = UIAlertController()
    
    lazy var rootVC = UIApplication.shared.keyWindow?.rootViewController
    
    static let shared = PushRemoteTool()
    
}

extension PushRemoteTool : UNUserNotificationCenterDelegate {
    
    func RegisterPush(launchOptions:[UIApplicationLaunchOptionsKey: Any]?){
        UMConfigure.initWithAppkey("5acd6693f43e4833c200007a", channel: "App Store")
        UMConfigure.setLogEnabled(true)
        
        let entity = UMessageRegisterEntity()
        entity.types = Int(UInt8(UMessageAuthorizationOptions.badge.rawValue) | UInt8(UMessageAuthorizationOptions.alert.rawValue) | UInt8(UMessageAuthorizationOptions.sound.rawValue))
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = PushRemoteTool.shared
        } else {
            // Fallback on earlier versions
        }
        
        UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity) { (granted, error) in
            if granted == true {
                // 用户选择了接收Push消息
            }else{
                
            }
            print(granted)
            
        }
    }
    
    
    //iOS10以下使用这两个方法接收通知
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        UMessage.setAutoAlert(false)
        if Int(UIDevice.current.systemVersion) ?? 0 < 10 {
            UMessage.didReceiveRemoteNotification(userInfo)
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    //iOS10新增：处理前台收到通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        self.alert1.dismiss(animated: true, completion: nil)
        
        let userInfo = notification.request.content.userInfo
        
        if notification.request.trigger is UNPushNotificationTrigger {
            
            //关闭友盟自带的弹出框
            
            UMessage.setAutoAlert(false)
            print(userInfo)
            let dic = userInfo["aps"] as! [AnyHashable : Any]
            let content = dic["alert"] as! [AnyHashable : Any]
            let mainTitle = content["body"]
            //应用处于前台时的远程推送接受
            let alert = UIAlertController(title: "消息提示", message: mainTitle as? String, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "立即查看", style: .default, handler: { (action) in
                //跳转订单详情页
                if dic["采购订单"] != nil {
                    let idstr = dic["采购订单"] as! String
                    
                    self.getPurchaseData(idstr: idstr)
                }
                if dic["销售订单"] != nil {
                    let idstr = dic["销售订单"] as! String
                    self.GetSaleOrderDetailData(idstr: idstr)
                }
            })
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.alert1 = alert
            
            rootVC?.present(alert, animated: true, completion:nil)
            
            print(userInfo)
            //必须加这句代码
            UMessage.didReceiveRemoteNotification(userInfo)
            
        } else {
            //应用处于后台时的本地推送接受
        }
        
        //当应用处于前台时提示设置，需要哪个可以设置哪一个
        
        completionHandler([.sound, .badge, .alert])
    }
    
    
    //iOS10新增：处理后台点击通知的代理方法
    
    @available(iOS 10.0, *)
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        if response.notification.request.trigger is UNPushNotificationTrigger {
            
            //应用处于后台时的远程推送接受
            
            //关闭友盟自带的弹出框
            
            UMessage.setAutoAlert(false)
            
            
            let dic = userInfo["aps"] as! [AnyHashable : Any]
            //跳转订单详情页
            if dic["采购订单"] != nil {
                let idstr = dic["采购订单"] as! String
                
                self.getPurchaseData(idstr: idstr)
            }
            if dic["销售订单"] != nil {
                let idstr = dic["销售订单"] as! String
                self.GetSaleOrderDetailData(idstr: idstr)
            }
            
            
            //必须加这句代码
            
            UMessage.didReceiveRemoteNotification(userInfo)
            
        } else {
            
            //应用处于后台时的本地推送接受
            
        }
        
    }
    
    //    //获取token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let device = NSData(data: deviceToken)
        let deviceId = device.description.replacingOccurrences(of:"<", with:"").replacingOccurrences(of:">", with:"").replacingOccurrences(of:" ", with:"")
        print(deviceId)
        UserDefaults.standard.set(deviceId, forKey: "deviceId")
    }
    
}

extension PushRemoteTool {
    func remotePush(_ launchOptions:[UIApplicationLaunchOptionsKey: Any]?){
        //集成友盟推送
        //
        UMConfigure.initWithAppkey("5acd6693f43e4833c200007a", channel: "App Store")
        UMConfigure.setLogEnabled(true)
        
        let entity = UMessageRegisterEntity()
        entity.types = Int(UInt8(UMessageAuthorizationOptions.badge.rawValue) | UInt8(UMessageAuthorizationOptions.alert.rawValue) | UInt8(UMessageAuthorizationOptions.sound.rawValue))
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        
        UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity) { (granted, error) in
            if granted == true {
                // 用户选择了接收Push消息
            }else{
                
            }
            print(granted)
            
        }
        
    }
    func getPurchaseData(idstr:String){
        guard let userInfo = ZJKeyChain.load("userInfo") as? [String:String] else {return}
        AlamofireTool.getRequest(URLString: getPurchOrderDetailUrl, params: ["PurchOrderId":idstr ,"UserId":userInfo["userId"]!], success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            SVProgressHUD.dismiss()
            guard let model = PurchaseFormDetailModel(JSON: result) else {return}
            let purchaseModel = model.purchaseModel
            let purchasDeTailVC = purchaseDetailVC()
            purchasDeTailVC.purchaseModel = purchaseModel
            purchasDeTailVC.isPushRemote = true
            self.rootVC?.present(CustomNavigationController(rootViewController: purchasDeTailVC), animated: true, completion: nil)
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    func GetSaleOrderDetailData (idstr:String) {
        guard let userInfo = ZJKeyChain.load("userInfo") as? [String:String] else {return}
        
        AlamofireTool.getRequest(URLString: GetSaleOrderDetailUrl, params: ["SaleOrderId":idstr ,"UserId":userInfo["userId"]!], success: { (result) in
            if result["Code"] as! String != "1" {
                SVProgressHUD.showError(withStatus: result["Message"] as! String)
                SVProgressHUD.dismiss(withDelay: 2)
                if result["Code"] as! String == "-1" {AlamofireTool.backReLoginVC()}
                return
            }
            SVProgressHUD.dismiss()
            guard let model = Sales0rderFormDetailModel(JSON: result) else {return}
            let salsesDetailModel = model.Data
            let salsesOrderFormDetailVC = SalsesOrderFormDetailVC()
            salsesOrderFormDetailVC.isPushRomote = true
            salsesOrderFormDetailVC.salesFormModel = salsesDetailModel
            //获得当前视图的控制器
            //            let parentVC = self.getCurrentController()
            
            //延时调用
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.25, execute: {
                self.rootVC?.present(CustomNavigationController(rootViewController: salsesOrderFormDetailVC), animated: true, completion: nil)
            })
            
            
        }) { (error) in
            SVProgressHUD.showError(withStatus: error as? String ?? "")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    //获得当前视图的控制器
    func getCurrentController() -> UIViewController? {
        
        guard let window = UIApplication.shared.windows.first else {
            return nil
        }
        
        var tempView: UIView?
        
        for subview in window.subviews.reversed() {
            
            
            if subview.classForCoder.description() == "UILayoutContainerView" {
                
                tempView = subview
                
                break
            }
        }
        
        if tempView == nil {
            
            tempView = window.subviews.last
        }
        
        var nextResponder = tempView?.next
        
        var next: Bool {
            return !(nextResponder is UIViewController) || nextResponder is UINavigationController || nextResponder is UITabBarController
        }
        
        while next{
            
            tempView = tempView?.subviews.first
            
            if tempView == nil {
                
                return nil
            }
            
            nextResponder = tempView!.next
        }
        
        return nextResponder as? UIViewController
    }
}

//
//  LeftMenuViewController.swift
//  InternalSystem
//
//  Created by gail on 2018/2/5.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class LeftMenuViewController: UITableViewController {
    
    lazy var imgNameArray = ["IconProfile","IconHome" ,"IconCalendar", "IconSettings","end"]
    lazy var infoArray : [String] = {
        var infoArray = [String]()
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String]{
            
            infoArray = [userInfo["name"]!,userInfo["roleNames"] ?? "",userInfo["lastTime"] ?? "" ,"修改密码    >","退出登录    >"]
        }
        return infoArray
    }()
    lazy var headerImg : UIImageView = {
       
        var headerImg = UIImageView(frame: CGRect(x: 15, y: 200-80-10, width: 80, height: 80))
        headerImg.layer.cornerRadius = headerImg.width/2
        headerImg.clipsToBounds = true
        headerImg.layer.borderColor = UIColor.white.cgColor
        headerImg.layer.borderWidth = 1
        return headerImg
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return infoArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "UserInfoCell")
            cell?.textLabel?.text = infoArray[indexPath.row]
            cell?.textLabel?.textColor = UIColor.white
            cell?.imageView?.image = UIImage(named:imgNameArray[indexPath.row])
        }
      
        cell?.selectionStyle = .none
        cell?.backgroundColor = UIColor.clear
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==3 {
            self.sideMenuViewController.hideVCAnimate(false)
        }
        if indexPath.row==4 {
            self.SignOut()
        }
        
        NotificationCenter.default.post(name: NSNotification.Name.init("pushVC"), object: indexPath.row)
       
    }
}
extension LeftMenuViewController {
    fileprivate func setupUI () {
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 54
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 200))
        backView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = backView
        backView.addSubview(headerImg)
        
        if let userInfo = ZJKeyChain.load("userInfo") as? [String:String] {
            headerImg.sd_setImage(with: URL(string:userInfo["empImg"]! ))
        }
    }
    fileprivate func ChangePwd(){
        
    }
    fileprivate func SignOut () {
        
            let alertVC = UIAlertController(title: nil, message: "确定要退出登录？", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let OKActoion = UIAlertAction(title: "OK", style: .destructive) { (action) in
                
                ZJKeyChain.delete("Login")
                UIApplication.shared.keyWindow?.rootViewController = LoginViewControllor()
            }
            alertVC.addAction(cancelAction)
            alertVC.addAction(OKActoion)
            self.present(alertVC, animated: true, completion: nil)
        
    }
}


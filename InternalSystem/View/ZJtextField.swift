//
//  ZJtextField.swift
//  InternalSystem
//
//  Created by gail on 2018/1/31.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class ZJtextField: UIView {
    
     lazy var textField : UITextField = {
        var textField = UITextField(frame: CGRect.zero)
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.delegate = self
        return textField
    }()
    
      lazy var placeHolderLabel : UILabel = {
        var placeHolderLabel = UILabel(frame: CGRect.zero)
        placeHolderLabel.font = UIFont.systemFont(ofSize: 13)
        placeHolderLabel.textColor = UIColor.white
        return placeHolderLabel
    }()
    
     lazy var lineView : UIView = {
        var lineView = UIView(frame: CGRect.zero)
        lineView.backgroundColor = UIColor.white
        lineView.layer.frame = CGRect.zero
        lineView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        lineView.layer.backgroundColor = UIColor.white.cgColor
        return lineView
    }()
    var moved : Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textField)
        addSubview(placeHolderLabel)
        addSubview(lineView)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"), object: nil, queue: nil) { (_) in
            self.changeFrameOfPlaceholder()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height-1)
        placeHolderLabel.frame = textField.frame
        lineView.frame = CGRect(x: 0, y: self.height-1, width: self.width, height: 1)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
extension ZJtextField : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
extension ZJtextField  {
    fileprivate func changeFrameOfPlaceholder () {
        
        if textField.text?.count != 0 , moved == false {
            placeHolderLabel.font = UIFont.systemFont(ofSize: 10)
            
            UIView.animate(withDuration: 0.15, animations: {[weak self] in
                self?.placeHolderLabel.center.x -= 5
                self?.placeHolderLabel.center.y -= (self?.placeHolderLabel.height)!/2 + 2
                
                self?.placeHolderLabel.center = CGPoint(x: (self?.placeHolderLabel.center.x)!, y: (self?.placeHolderLabel.center.y)!)
                self?.placeHolderLabel.alpha = 1
                self?.moved = true
            })
            
            
        }else if textField.text?.count == 0 , moved == true {
            placeHolderLabel.font = UIFont.systemFont(ofSize: 13)
            UIView.animate(withDuration: 0.15, animations: {[weak self] in
                self?.placeHolderLabel.center.x += 5
                self?.placeHolderLabel.center.y += (self?.placeHolderLabel.height)!/2 + 2
                 self?.placeHolderLabel.center = CGPoint(x: (self?.placeHolderLabel.center.x)!, y: (self?.placeHolderLabel.center.y)!)
                self?.placeHolderLabel.alpha = 1
                self?.moved = false
            })
        }
    }
}

//
//  WarehouseCell.swift
//  InternalSystem
//
//  Created by gail on 2018/3/13.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class WarehouseCell: UITableViewCell {

    @IBOutlet weak var whNameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var isDefaultLabel: UILabel!
    @IBOutlet weak var isLockLabel: UILabel!
    @IBOutlet weak var reMarkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override var frame:CGRect{
        didSet {
            var newFrame = frame
            newFrame.origin.x += 20/2
            newFrame.size.width -= 20
            //            newFrame.origin.y += 10
            //            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
    
}

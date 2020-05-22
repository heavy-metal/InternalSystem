//
//  ClientInfoCell.swift
//  InternalSystem
//
//  Created by gail on 2018/2/23.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class ClientInfoCell: UITableViewCell {

    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var collectMoneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
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

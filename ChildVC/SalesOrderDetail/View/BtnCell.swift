//
//  BtnCell.swift
//  InternalSystem
//
//  Created by gail on 2018/2/7.
//  Copyright © 2018年 NewSwift. All rights reserved.
//

import UIKit

class BtnCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title_Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        icon.layer.cornerRadius = icon.width/2
        icon.clipsToBounds = true
    }

}

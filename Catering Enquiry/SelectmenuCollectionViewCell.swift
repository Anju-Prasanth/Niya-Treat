//
//  SelectmenuCollectionViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 02/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class SelectmenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblmenu: UILabel!
    @IBOutlet weak var btncheckbox: UIButton!
    @IBOutlet weak var Outerview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        Outerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
               Outerview.layer.shadowRadius = 5.0
               Outerview.layer.shadowOpacity=0.1
               Outerview.layer.cornerRadius=10
    }

}

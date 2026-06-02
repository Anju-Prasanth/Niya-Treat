//
//  ExpandedarrayTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 14/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class ExpandedarrayTableViewCell: UITableViewCell {
    @IBOutlet weak var lblsubproducts: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var imagehighlighted: UIImageView!
    @IBOutlet weak var btnselection: UIButton!
     var isSelectedAddress = Bool()
    override func awakeFromNib() {
        super.awakeFromNib()
       btnselection.layer.masksToBounds = true
           btnselection.layer.cornerRadius = 10 //btncartcount.frame.width/2
           btnselection.layer.borderWidth=1
        btnselection.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

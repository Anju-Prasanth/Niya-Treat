//
//  PartywithdoormenuTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 03/08/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class PartywithdoormenuTableViewCell: UITableViewCell {

    @IBOutlet weak var lbltotal: UILabel!
    @IBOutlet weak var lblqtity: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lbldoormenu: UILabel!
    @IBOutlet weak var imageviewdoormenu: UIImageView!
    @IBOutlet weak var Outerview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       Outerview.layer.shadowRadius = 3
                  Outerview.layer.shadowOpacity = 1
                                           
                  Outerview.clipsToBounds=false
                  Outerview.layer.shadowColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

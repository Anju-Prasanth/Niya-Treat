//
//  PriceTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 29/04/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {

    @IBOutlet weak var lbltaxcharge: UILabel!
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lblgrandtotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Outerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
           Outerview.layer.shadowRadius = 3
           Outerview.layer.shadowOpacity = 1
                                    
           Outerview.clipsToBounds=false
           Outerview.layer.shadowColor = UIColor.black.cgColor
        Outerview.layer.cornerRadius=10
        
          
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

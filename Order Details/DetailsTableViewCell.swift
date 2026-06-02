//
//  DetailsTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 29/04/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lbltotal: UILabel!
    @IBOutlet weak var lblquantity: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var imageviewproduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       Outerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
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

//
//  ProductdetailsTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 28/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class ProductdetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnremovefromcart: UIButton!
    @IBOutlet weak var btnplus: UIButton!
    @IBOutlet weak var lblnumbers: UILabel!
    @IBOutlet weak var btnminus: UIButton!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var imageviewtype: UIImageView!
    @IBOutlet weak var lbltype: UILabel!
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var imageviewproduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

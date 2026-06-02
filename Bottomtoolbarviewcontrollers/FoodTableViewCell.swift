//
//  FoodTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 26/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var btnpartyorder: UIButton!
    @IBOutlet weak var btndoordelivery: UIButton!
    @IBOutlet weak var btntakeaway: UIButton!
    @IBOutlet weak var btntablebooking: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  DishesTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 27/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class DishesTableViewCell: CommonTableViewCell {

    @IBOutlet weak var lblnoofchoosendishes: UILabel!
    @IBOutlet weak var lbldishname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

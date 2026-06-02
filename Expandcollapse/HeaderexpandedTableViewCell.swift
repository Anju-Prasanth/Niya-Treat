//
//  HeaderexpandedTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 09/06/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class HeaderexpandedTableViewCell: UITableViewCell {

    @IBOutlet weak var lbldash: UILabel!
    @IBOutlet weak var btnheadertapped: UIButton!
    @IBOutlet weak var lblcountitems: UILabel!
    @IBOutlet weak var imageviewitem: UIImageView!
    @IBOutlet weak var lblitemnamr: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  WorldclasscouisineTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 18/12/19.
//  Copyright © 2019 Arun Vijayan. All rights reserved.
//

import UIKit

class WorldclasscouisineTableViewCell: UITableViewCell {
    @IBOutlet weak var imageviewpooram: UIImageView!
    
    @IBOutlet weak var imageviewheight: NSLayoutConstraint!
    @IBOutlet weak var btndoordelivery: UIButton!
    @IBOutlet weak var btnpartyorder: UIButton!
    @IBOutlet weak var btntablebooking: UIButton!
    @IBOutlet weak var btntakeaway: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageviewpooram.layer.cornerRadius=5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

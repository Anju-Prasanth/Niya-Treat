//
//  Package3TableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 27/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class Package3TableViewCell: UITableViewCell {
    @IBOutlet weak var Outerview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Outerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        Outerview.layer.shadowRadius = 5.0
        Outerview.layer.shadowOpacity = 0.1
        Outerview.layer.cornerRadius=10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

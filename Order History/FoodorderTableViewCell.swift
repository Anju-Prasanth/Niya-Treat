//
//  FoodorderTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 29/04/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class FoodorderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblgranttotal: UILabel!
    @IBOutlet weak var btndetails: UIButton!
    @IBOutlet weak var lblorderstatus: UILabel!
    @IBOutlet weak var lblcreateddate: UILabel!
    @IBOutlet weak var lblordercode: UILabel!
    @IBOutlet weak var Outerview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       Outerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        Outerview.layer.shadowRadius = 5.0
        Outerview.layer.shadowOpacity = 0.1
        Outerview.layer.cornerRadius=10
        
        btndetails.layer.cornerRadius=10
        btndetails.layer.borderColor=UIColor.lightGray.cgColor
        btndetails.layer.borderWidth=1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

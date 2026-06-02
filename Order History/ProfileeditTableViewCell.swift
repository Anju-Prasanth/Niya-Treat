//
//  ProfileeditTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 20/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class ProfileeditTableViewCell: UITableViewCell {

    @IBOutlet weak var btncancelrequest: UIButton!
    @IBOutlet weak var btnsubmitreview: UIButton!
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lvblcheckoutdate: UILabel!
    @IBOutlet weak var lblbookingcode: UILabel!
    @IBOutlet weak var lblcheckindate: UILabel!
    @IBOutlet weak var lblroomname: UILabel!
    @IBOutlet weak var imageviewroom: UIImageView!
    @IBOutlet weak var lbldate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       Outerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
               Outerview.layer.shadowRadius = 5.0
               Outerview.layer.shadowOpacity=0.1
               Outerview.layer.cornerRadius=10
         lbldate.layer.masksToBounds=true
        lbldate.layer.cornerRadius=10
        
         //lbldate.layer.cornerRadius=10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

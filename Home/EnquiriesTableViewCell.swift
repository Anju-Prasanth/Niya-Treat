//
//  EnquiriesTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 19/12/19.
//  Copyright © 2019 Arun Vijayan. All rights reserved.
//

import UIKit

class EnquiriesTableViewCell: UITableViewCell {

    @IBOutlet weak var btnpackageenquiry: UIButton!
    @IBOutlet weak var btncateringenquiry: UIButton!
    @IBOutlet weak var btnbanquetenquiry: UIButton!
    @IBOutlet weak var viewpackages: UIView!
    @IBOutlet weak var viewcatering: UIView!
    @IBOutlet weak var viewbanquet: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       viewbanquet.layer.cornerRadius=10
        // Outerview.layer.shadowColor = UIColor.lightGray.cgColor
         viewbanquet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
         viewbanquet.layer.shadowRadius = 5.0
         viewbanquet.layer.shadowOpacity = 0.1
        viewcatering.layer.cornerRadius=10
        // Outerview.layer.shadowColor = UIColor.lightGray.cgColor
         viewcatering.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
         viewcatering.layer.shadowRadius = 5.0
         viewcatering.layer.shadowOpacity = 0.1
        viewpackages.layer.cornerRadius=10
        // Outerview.layer.shadowColor = UIColor.lightGray.cgColor
         viewpackages.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
         viewpackages.layer.shadowRadius = 5.0
         viewpackages.layer.shadowOpacity = 0.1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

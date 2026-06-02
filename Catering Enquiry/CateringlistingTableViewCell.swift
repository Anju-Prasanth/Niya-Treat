//
//  CateringlistingTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 26/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class CateringlistingTableViewCell: UITableViewCell {

    @IBOutlet weak var lblmenutype: UILabel!
    @IBOutlet weak var viewmenu4: UIView!
    @IBOutlet weak var viewmenu3: UIView!
    @IBOutlet weak var viewmenu2: UIView!
    @IBOutlet weak var viewmenu1: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblmenutype.layer.cornerRadius=15
        lblmenutype.clipsToBounds=true
        viewmenu4.clipsToBounds=true
        viewmenu3.clipsToBounds=true
        viewmenu2.clipsToBounds=true
        viewmenu1.clipsToBounds=true
//        viewmenu1.layer.borderColor = UIColor.lightGray.cgColor
//         viewmenu1.layer.borderWidth=1
        
        
        viewmenu4.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewmenu4.layer.shadowRadius = 5.0
        viewmenu4.layer.shadowOpacity = 0.1
        viewmenu4.layer.cornerRadius=10
        viewmenu3.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewmenu3.layer.shadowRadius = 5.0
        viewmenu3.layer.shadowOpacity = 0.1
         viewmenu2.layer.cornerRadius=10
        viewmenu2.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewmenu2.layer.shadowRadius = 5.0
        viewmenu2.layer.shadowOpacity = 0.1
         viewmenu2.layer.cornerRadius=10
        viewmenu1.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewmenu1.layer.shadowRadius = 5.0
        viewmenu1.layer.shadowOpacity = 0.1
         viewmenu1.layer.cornerRadius=10
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

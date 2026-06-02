//
//  BookyournightsTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 18/12/19.
//  Copyright © 2019 Arun Vijayan. All rights reserved.
//

import UIKit

class BookyournightsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageviewsearch: UIImageView!
    @IBOutlet weak var lblbookyournigts: UILabel!
    @IBOutlet weak var lblroombooking: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btnguests: UIButton!
    @IBOutlet weak var lbltotalchild: UILabel!
    @IBOutlet weak var lbltotaladult: UILabel!
    @IBOutlet weak var btnrooms: UIButton!
    @IBOutlet weak var lbltotalrooms: UILabel!
    @IBOutlet weak var lbltotalnumbers: UILabel!
    @IBOutlet weak var checkoutyear: UILabel!
    @IBOutlet weak var checkinyear: UILabel!
    @IBOutlet weak var btncheckout: UIButton!
    @IBOutlet weak var checkoutweekday: UILabel!
    @IBOutlet weak var checkoutmonth: UILabel!
    @IBOutlet weak var checkoutday: UILabel!
    @IBOutlet weak var checkinweekday: UILabel!
    @IBOutlet weak var checkinmonth: UILabel!
    @IBOutlet weak var checkinday: UILabel!
    @IBOutlet weak var btncheckin: UIButton!
    
    @IBOutlet weak var btnsearch: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

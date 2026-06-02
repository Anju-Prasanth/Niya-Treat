//
//  PartyreviewTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 07/05/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class PartyreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var lblwriteareview: UILabel!
    @IBOutlet weak var btnsubmitt: UIButton!
     @IBOutlet weak var txtviewpartyreview: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
  
               btnsubmitt.layer.cornerRadius=10
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

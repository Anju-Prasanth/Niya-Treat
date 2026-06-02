//
//  BanquetenurypopuptTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 01/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import iOSDropDown

class BanquetenurypopuptTableViewCell: UITableViewCell {

    @IBOutlet weak var btnsubmitt: UIButton!
    @IBOutlet weak var txtfldendadte: UITextField!
    @IBOutlet weak var txtfldstartdate: UITextField!
    @IBOutlet weak var txtfldendtime: UITextField!
    @IBOutlet weak var txtfldstarttime: UITextField!
    @IBOutlet weak var txtfldpax: DropDown!
    @IBOutlet weak var txtfldoccassion: DropDown!
    @IBOutlet weak var txtfldemail: UITextField!
    @IBOutlet weak var txtfldphonenumber: UITextField!
    @IBOutlet weak var txtfldname: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
       txtfldoccassion.layer.cornerRadius=5
               txtfldoccassion.layer.borderWidth=1
               txtfldoccassion.layer.borderColor = UIColor.lightGray.cgColor
               txtfldendadte.layer.cornerRadius=5
               txtfldendadte.layer.borderWidth=1
               txtfldendadte.layer.borderColor = UIColor.lightGray.cgColor
               txtfldstartdate.layer.cornerRadius=5
               txtfldstartdate.layer.borderWidth=1
               txtfldstartdate.layer.borderColor = UIColor.lightGray.cgColor
               txtfldendtime.layer.cornerRadius=5
               txtfldendtime.layer.borderWidth=1
               txtfldendtime.layer.borderColor = UIColor.lightGray.cgColor
               txtfldstarttime.layer.cornerRadius=5
               txtfldstarttime.layer.borderWidth=1
               txtfldstarttime.layer.borderColor = UIColor.lightGray.cgColor
               txtfldemail.layer.cornerRadius=5
               txtfldemail.layer.borderWidth=1
               txtfldemail.layer.borderColor = UIColor.lightGray.cgColor
               txtfldphonenumber.layer.cornerRadius=5
                      txtfldphonenumber.layer.borderWidth=1
                      txtfldphonenumber.layer.borderColor = UIColor.lightGray.cgColor
               txtfldname.layer.cornerRadius=5
                      txtfldname.layer.borderWidth=1
                      txtfldname.layer.borderColor = UIColor.lightGray.cgColor
        txtfldpax.layer.cornerRadius=5
                             txtfldpax.layer.borderWidth=1
                             txtfldpax.layer.borderColor = UIColor.lightGray.cgColor
               
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

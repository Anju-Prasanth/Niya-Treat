//
//  pickupserviceTableViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 14/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import  iOSDropDown

class pickupserviceTableViewCell: UITableViewCell {

    @IBOutlet weak var btnam: UIButton!
    @IBOutlet weak var btnpm: UIButton!
    @IBOutlet weak var txtfldpm: UITextField!
    @IBOutlet weak var txtfldam: UITextField!
    @IBOutlet weak var txtfldminute: UITextField!
    @IBOutlet weak var txtfldhour: UITextField!
    @IBOutlet weak var txtfldtravellername: UITextField!
    @IBOutlet weak var txtfldtravellernumber: UITextField!
    @IBOutlet weak var txtfldtrainnumber: UITextField!
    @IBOutlet weak var txtfldchoosecount: DropDown!
    @IBOutlet weak var txtfldchoosecar: DropDown!
    @IBOutlet weak var txtfldarrivingat: UITextField!
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var trainnumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        Outerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        Outerview.layer.shadowRadius = 5.0
        Outerview.layer.shadowOpacity = 0.1

       let txtfldcolor = UIColor(red: 161 / 255, green: 161 / 255, blue: 161 / 255, alpha: 1.0)
               
        txtfldpm.borderStyle=UITextField.BorderStyle.roundedRect
        txtfldam.borderStyle=UITextField.BorderStyle.roundedRect
        txtfldminute.borderStyle=UITextField.BorderStyle.roundedRect
        txtfldhour.borderStyle=UITextField.BorderStyle.roundedRect
        txtfldtravellername.borderStyle=UITextField.BorderStyle.roundedRect
        txtfldtravellernumber.borderStyle=UITextField.BorderStyle.roundedRect
         txtfldarrivingat.borderStyle=UITextField.BorderStyle.roundedRect
        txtfldchoosecount.borderStyle=UITextField.BorderStyle.roundedRect
        txtfldchoosecar.borderStyle=UITextField.BorderStyle.roundedRect
         txtfldtrainnumber.borderStyle=UITextField.BorderStyle.roundedRect
               
              txtfldpm.layer.borderColor = txtfldcolor.cgColor
              txtfldam.layer.borderColor = txtfldcolor.cgColor
              txtfldminute.layer.borderColor = txtfldcolor.cgColor
             txtfldhour.layer.borderColor = txtfldcolor.cgColor
              txtfldtravellername.layer.borderColor = txtfldcolor.cgColor
               
              txtfldtravellernumber.layer.borderColor = txtfldcolor.cgColor
               txtfldarrivingat.layer.borderColor = txtfldcolor.cgColor
              txtfldchoosecount.layer.borderColor = txtfldcolor.cgColor
                     txtfldchoosecar.layer.borderColor = txtfldcolor.cgColor
          txtfldtrainnumber.layer.borderColor = txtfldcolor.cgColor
              
               
              txtfldpm.layer.borderWidth = 1
             txtfldpm.layer.cornerRadius = 5
            txtfldam.layer.borderWidth = 1
            txtfldam.layer.cornerRadius = 5
        
                  txtfldarrivingat.layer.borderWidth = 1
                    txtfldarrivingat.layer.cornerRadius = 5
                 txtfldtravellernumber.layer.borderWidth = 1
               txtfldtravellernumber.layer.cornerRadius = 5
        
                    txtfldhour.layer.borderWidth = 1
                   txtfldhour.layer.cornerRadius = 5
                  txtfldminute.layer.borderWidth = 1
                     txtfldminute.layer.cornerRadius = 5
        txtfldchoosecar.layer.borderWidth = 1
         txtfldchoosecar.layer.cornerRadius = 5
        txtfldchoosecount.layer.borderWidth = 1
           txtfldchoosecount.layer.cornerRadius = 5
        txtfldtravellername.layer.borderWidth = 1
        txtfldtravellername.layer.cornerRadius = 5
        txtfldtrainnumber.layer.borderWidth = 1
        txtfldtrainnumber.layer.cornerRadius = 5
    }
    
}

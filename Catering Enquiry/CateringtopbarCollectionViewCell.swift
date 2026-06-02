//
//  CateringtopbarCollectionViewCell.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 26/01/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit

class CateringtopbarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblscrolldirection: UILabel!
    @IBOutlet weak var lblmenus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblscrolldirection.sizeToFit()
        lblmenus.sizeToFit()
    }

}

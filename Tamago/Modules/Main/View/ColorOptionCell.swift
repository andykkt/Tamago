//
//  ColorOptionCell.swift
//  Tamago
//
//  Created by Andy Kim on 1/5/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

class ColorOptionCell: UITableViewCell {

    @IBOutlet weak var colorOptionView: ColorOptionView!
    
    var color: UIColor = UIColor(hexString: "#000000") {
        didSet {
            colorOptionView.color = color
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        colorOptionView.isSelected = selected
    }

}

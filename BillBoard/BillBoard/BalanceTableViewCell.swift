//
//  BalanceTableViewCell.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit
import Spring

class BalanceTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dollarSignLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var backView: SpringView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.animation = "fadeIn"
        backView.animate()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateBalanceLabelColor() {
        let greenColor = UIColor(hex: "39AE54")
        let redColor = UIColor(hex: "E24E35")
        if let balance = balanceLabel.text {
            if balance.lowercaseString.rangeOfString("-") != nil {
                balanceLabel.textColor = redColor
                dollarSignLabel.textColor = redColor
            } else {
                balanceLabel.textColor = greenColor
                dollarSignLabel.textColor = greenColor
            }
        }
    }
    
}

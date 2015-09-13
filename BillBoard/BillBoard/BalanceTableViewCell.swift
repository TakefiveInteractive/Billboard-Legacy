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
    @IBOutlet weak var marginColorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.animation = "fadeIn"
        backView.animate()
        
        avatarImageView.image = DataManager.randomAvatar()
        nameLabel.text = DataManager.randomName()
        balanceLabel.text = NSString(format: "%.02f", DataManager.randomDecimal()) as String
        updateBalanceLabelColor()
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
                dollarSignLabel.text = "Owes"
                marginColorImageView.backgroundColor = redColor
            } else {
                balanceLabel.textColor = greenColor
                dollarSignLabel.textColor = greenColor
                dollarSignLabel.text = "Is owed"
                marginColorImageView.backgroundColor = greenColor
            }
        }
    }
    
}

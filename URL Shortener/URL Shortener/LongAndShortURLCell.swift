//
//  LongAndShortURLCell.swift
//  URL Shortener
//
//  Created by Ryan on 2020-04-24.
//  Copyright © 2020 Ryan Ball. All rights reserved.
//

import UIKit

class LongAndShortURLCell: UITableViewCell {
    
    var longURL: String = "" {
        didSet {
            if (longURL != oldValue) {
                longURLLabel.text = longURL
            }
        }
    }
    var shortURL: String = "" {
        didSet {
            if (shortURL != oldValue) {
                shortURLLabel.text = shortURL
            }
        }
    }
@IBOutlet var longURLLabel: UILabel!
@IBOutlet var shortURLLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

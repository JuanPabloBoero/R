//
//  RedditTableViewCell.swift
//  R
//
//  Created by Juan Pablo Boero Alvarez on 5/6/17.
//  Copyright © 2017 jpba. All rights reserved.
//

import UIKit

class RedditTableViewCell: UITableViewCell {

    @IBOutlet weak var redditImageView: UIImageView!
    @IBOutlet weak var redditTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

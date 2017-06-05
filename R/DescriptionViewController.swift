//
//  DescriptionViewController.swift
//  R
//
//  Created by Juan Pablo Boero Alvarez on 4/6/17.
//  Copyright © 2017 jpba. All rights reserved.
//

import UIKit
import Kingfisher

class DescriptionViewController: UIViewController {

    @IBOutlet weak var redditImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var subredditLabel: UILabel!
    
    
    @IBOutlet weak var redditImageViewHeightConstraint: NSLayoutConstraint!
    
    // The passed reddit.
    var selectedReddit: MThing?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fill()
        
    }

    func fill() {
        if let reddit = selectedReddit {
            
            // Image
            
            if let thumbURLString = reddit.thumbnailURL {
                if !thumbURLString.contains("http") {
                    view.layoutIfNeeded()
                    self.redditImageViewHeightConstraint.constant = 0
                    UIView.animate(withDuration: 0.4, animations: {
                        self.view.layoutIfNeeded()
                    })
                } else {
                    redditImageView.kf.setImage(with: URL(string: thumbURLString))
                }
            }
            
            // Title
            titleLabel.text = reddit.title
            
            // Author
            authorTitleLabel.text = reddit.author
            
            // Creation Date
            if let date = reddit.dateUnixTimeStamp {
                dateLabel.text = "\(date.stringDateFromUnixValue())"
            }
            
            // Comments Count
            if let commentsCount = reddit.commentsCount {
                commentsCountLabel.text = "\(commentsCount)"
            }
            
            // Sub Reddit
            subredditLabel.text = reddit.subreddit
            
        }
    }
    
}

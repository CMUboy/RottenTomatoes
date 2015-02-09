//
//  MovieTableViewCell.swift
//  RottenTomatoes
//
//  Created by Joseph Ku on 2/5/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    var movie: NSDictionary? {
        get {
            return self.movie
        }
        set {
            self.title = newValue!["title"] as String
            var imageUrl = (newValue!["posters"] as NSDictionary)["thumbnail"] as String
            imageUrl = imageUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
            movieImage.setImageWithURL(NSURL(string: imageUrl))
        }
    }
    
    var title: String {
        get {
            return titleLabel.text!
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

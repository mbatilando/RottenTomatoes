//
//  MovieTitleCell.swift
//  RottenTomatoes
//
//  Created by Mari Batilando on 2/3/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieActorsLabel: UILabel!
    @IBOutlet weak var movieLengthLabel: UILabel!
    @IBOutlet weak var movieAudienceRatingLabel: UILabel!
    @IBOutlet weak var mpaaRatingLabel: UILabel!
   
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        if highlighted {
            self.movieTitleLabel.textColor = UIColor.yellowColor()
            self.movieRatingLabel.textColor = UIColor.yellowColor()
            self.movieLengthLabel.textColor = UIColor.yellowColor()
            self.movieAudienceRatingLabel.textColor = UIColor.yellowColor()
            self.movieActorsLabel.textColor = UIColor.yellowColor()
            self.mpaaRatingLabel.textColor = UIColor.yellowColor()
        } else {
            self.movieTitleLabel.textColor = UIColor.whiteColor()
            self.movieRatingLabel.textColor = UIColor.whiteColor()
            self.movieLengthLabel.textColor = UIColor.whiteColor()
            self.movieAudienceRatingLabel.textColor = UIColor.whiteColor()
            self.movieActorsLabel.textColor = UIColor.whiteColor()
            self.mpaaRatingLabel.textColor = UIColor.whiteColor()
        }
    }
}

//
//  MovieDetailsViewController.swift
//  
//
//  Created by Mari Batilando on 2/7/15.
//
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var criticsScoreLabel: UILabel!
    @IBOutlet weak var audienceScoreLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var artistsLabel: UILabel!
    
    var movie: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.movie != nil {
            movieTitleLabel.text = self.movie!["title"] as NSString
//            criticsScoreLabel.text = String(mRatings["critics_score"] as NSInteger)
        }
    }
}

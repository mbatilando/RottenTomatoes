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
    @IBOutlet weak var artistsLabel: UILabel!
    @IBOutlet var rootViewContainer: UIView!
    @IBOutlet weak var scrollViewContainer: UIScrollView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var mpaaRatingsLabel: UILabel!

    var movie: NSDictionary?
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        self.scrollViewContainer.layoutIfNeeded()
        self.scrollViewContainer.contentSize = self.rootViewContainer.bounds.size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.movie != nil {
            mpaaRatingsLabel.text = self.movie!["mpaa_rating"] as NSString
            movieTitleLabel.text = self.movie!["title"] as NSString
            let mRatings = self.movie!["ratings"] as NSDictionary
            criticsScoreLabel.text = String(mRatings["critics_score"] as NSInteger)
            audienceScoreLabel.text = String(mRatings["audience_score"] as NSInteger)
            movieDescriptionLabel.text = self.movie!["synopsis"] as NSString
            
            let actorsArray = self.movie!["abridged_cast"] as NSArray
            let numActors = actorsArray.count > 3 ? 3 : actorsArray.count
            var topActors = ""
            for i in 0..<numActors {
                var actorObj = actorsArray[i] as NSDictionary
                topActors += actorObj["name"] as NSString + ", "
            }
            
            artistsLabel.text = topActors
            
            
            let mThumbnail = self.movie!["posters"] as NSDictionary
            let thumbnail = mThumbnail["thumbnail"] as String
            let lowResUrl = NSURL(string: thumbnail)
            let lowUrlRequest = NSURLRequest(URL: lowResUrl!)
            let highDef = thumbnail.stringByReplacingOccurrencesOfString("_tmb", withString: "_ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
            let highResUrl = NSURL(string: highDef)
            let highResUrlRequest = NSURLRequest(URL: highResUrl!)
            loadImage(url: lowUrlRequest, imageView: self.movieImage, {
                self.loadImage(url: highResUrlRequest, imageView: self.movieImage, closure: {})
                
            })
        }
    }
    
    func loadImage(#url: NSURLRequest, imageView: UIImageView, closure: (() -> ())?) {
        imageView.setImageWithURLRequest(url, placeholderImage: nil,
            success: {(request: NSURLRequest!,response: NSHTTPURLResponse!, image: UIImage!) -> Void in
                imageView.image = image
                closure?()
            },
            failure: {
                (request: NSURLRequest!,response: NSHTTPURLResponse!, error: NSError!) -> Void in
        })
    }
}

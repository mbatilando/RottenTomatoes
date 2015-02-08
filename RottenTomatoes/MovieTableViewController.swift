//
//  MovieTableViewController.swift
//  RottenTomatoes
//
//  Created by Mari Batilando on 2/7/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    @IBOutlet var moviesTableView: UITableView!
    @IBOutlet weak var networkErrorViewContainer: UIView!
    
    
    var movies: NSArray?
    var chosenMovie: NSDictionary?
    var rc: UIRefreshControl!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Refresh Control
        rc = UIRefreshControl()
        rc.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        moviesTableView.insertSubview(rc, atIndex: 0)
        
        // Fetching Data and HUD
        SVProgressHUD.show()
        fetchData({
            SVProgressHUD.showSuccessWithStatus("Sucess!")
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        SVProgressHUD.setBackgroundColor(UIColor.clearColor())
        super.viewDidAppear(animated)
    }
    
    func fetchData( closure: (()->())? ) {
        let YourApiKey = "esxztx7fqksg7psa53gd3wd5"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=\(YourApiKey)"
        let request = NSMutableURLRequest(URL: NSURL(string: RottenTomatoesURLString)!)

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            if error == nil {
                var errorValue: NSError? = nil
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
                self.movies = dictionary["movies"] as NSArray
                self.tableView.reloadData()
                closure?()
            } else {
                self.networkErrorViewContainer.hidden = false
                SVProgressHUD.showSuccessWithStatus("Failed")
            }
        })
    }
    
    func onRefresh() {
        fetchData({
            self.rc.endRefreshing()
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = movies {
            return array.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movie = self.movies![indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("com.MariBatilando.cell") as MovieTableViewCell
        cell.movieTitleLabel.text = movie["title"] as NSString
        //        cell.movieActorLabel.text = movie[""]
        cell.movieLengthLabel.text = String(movie["runtime"] as NSInteger) + " min"
        let mRatings = movie["ratings"] as NSDictionary
        cell.movieRatingLabel.text = String(mRatings["critics_score"] as NSInteger)
        
        let actorsArray = movie["abridged_cast"] as NSArray
        let numActors = actorsArray.count > 3 ? 3 : actorsArray.count
        var topActors = ""
        for i in 0..<numActors {
            var actorObj = actorsArray[i] as NSDictionary
            topActors += actorObj["name"] as NSString + ", "
        }
        
        cell.movieActorsLabel.text = topActors
        
        let mThumbnail = movie["posters"] as NSDictionary
        let thumbnail = mThumbnail["thumbnail"] as String
        let highDef = thumbnail.stringByReplacingOccurrencesOfString("_tmb", withString: "_ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let url = NSURL(string: highDef)
        let mUrl = NSURLRequest(URL: url!)
        let placeholder = UIImage(named: "MoviePlaceholder")
        
        cell.movieThumbnail.setImageWithURLRequest(mUrl, placeholderImage: placeholder,
            success:{(request: NSURLRequest!,response: NSHTTPURLResponse!, image: UIImage!) -> Void in
                cell.movieThumbnail.alpha = 0
                cell.movieThumbnail.image = image
                UIView.animateWithDuration(0.7, animations: {
                    cell.movieThumbnail.alpha = 1.0
                })
            },
            failure: {
                (request: NSURLRequest!,response: NSHTTPURLResponse!, error: NSError!) -> Void in
            })
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            let detailViewController = segue.destinationViewController as MovieDetailsViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow()
            let row = myIndexPath?.row
            detailViewController.movie = self.movies![row!] as NSDictionary
    }
}

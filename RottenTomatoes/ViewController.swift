//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Mari Batilando on 2/3/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var movies: NSArray?
    var chosenMovie: NSDictionary?

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let YourApiKey = "esxztx7fqksg7psa53gd3wd5"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=\(YourApiKey)"
        let request = NSMutableURLRequest(URL: NSURL(string: RottenTomatoesURLString)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            self.movies = dictionary["movies"] as NSArray
            self.tableView.reloadData()
        })
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = movies {
            return array.count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movie = self.movies![indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("com.MariBatilando.cell") as MovieTableViewCell
        cell.movieTitleLabel.text = movie["title"] as NSString
//        cell.movieActorLabel.text = movie[""]
        cell.movieLengthLabel.text = String(movie["runtime"] as NSInteger)
        let mRatings = movie["ratings"] as NSDictionary
        cell.movieRatingLabel.text = String(mRatings["critics_score"] as NSInteger)
        let mThumbnail = movie["posters"] as NSDictionary
        let thumbnail = mThumbnail["thumbnail"] as NSString
        let url = NSURL(string: thumbnail)
        cell.movieImage.setImageWithURL(url)
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let details = MovieDetailsViewController()
        chosenMovie = self.movies![indexPath.row] as NSDictionary
        details.movie = chosenMovie
        self.navigationController?.pushViewController(details, animated: true)
    }

}


//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Mari Batilando on 2/3/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let YourApiKey = "esxztx7fqksg7psa53gd3wd5"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=\(YourApiKey)"
        let request = NSMutableURLRequest(URL: NSURL(string: RottenTomatoesURLString)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
        })
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.MariBatilando.cell") as MovieTableViewCell
        cell.movieTitleLabel.text = "Row \(indexPath.row)"
        return cell
    }
    

}


//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Mari Batilando on 2/3/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var criticScoreLabel: UILabel!
    @IBOutlet weak var audienceScoreLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var descriptionsLabel: UILabel!
    
    
    var movie: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView() {
    }
    
    override func viewDidAppear(animated: Bool) {
        SVProgressHUD.show()
        super.viewDidAppear(animated)
        
    }
}

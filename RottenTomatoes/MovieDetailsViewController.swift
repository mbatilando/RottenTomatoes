//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Mari Batilando on 2/3/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movie: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView() {
        let myView = UIView(frame: CGRectZero)
        myView.backgroundColor = UIColor.greenColor()
        self.view = myView 
    }
}

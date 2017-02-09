//
//  ViewController.swift
//  CinemaSideKick
//
//  Created by Santi Angelo Pierini on 2/8/17.
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var movieTitle: UILabel!

    @IBAction func nextMovie(_ sender: UIButton) {
        movieTitle.text = "Default"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}


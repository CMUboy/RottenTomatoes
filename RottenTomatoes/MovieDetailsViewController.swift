//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Joseph Ku on 2/5/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movie: NSDictionary?
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var synopsisText: UILabel!
    @IBOutlet weak var ratingsText: UILabel!
    @IBOutlet weak var titleText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let title = movie!["title"] as String
        let year = String(movie!["year"] as UInt)
        let mpaaRating = movie!["mpaa_rating"] as String
        let synopsis = movie!["synopsis"] as? String
        let criticsScore = String((movie!["ratings"] as NSDictionary)["critics_score"] as UInt)
        let audienceScore = String((movie!["ratings"] as NSDictionary)["audience_score"] as UInt)
        
        navigationItem.title = title
        var imageUrl = (movie!["posters"] as NSDictionary)["thumbnail"] as String
        imageUrl = imageUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        movieImage.setImageWithURL(NSURL(string: imageUrl))
        
        synopsisText.text = synopsis
        titleText.text = "\(title) (\(year))"
        ratingsText.text = "Critics Score: \(criticsScore), Audience Score: \(audienceScore)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

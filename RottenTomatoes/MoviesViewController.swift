//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Joseph Ku on 2/5/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessage: UILabel!
    
    var refreshControl: UIRefreshControl!

    var movies: NSArray?
    
    let simpleTableIdentifier = "SimpleTableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self;
        tableView.delegate = self;

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        SVProgressHUD.show()

        reloadTableData()
    }

    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        reloadTableData()
        self.refreshControl.endRefreshing()
    }
    
    private func reloadTableData() {
        let apiKey = "6yg76v5asyk38s2wmd4zrnzm"
        let topBoxOfficeURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?&apikey=" + apiKey
        
        var request = NSMutableURLRequest(URL: NSURL(string: topBoxOfficeURLString)!)
        request.cachePolicy = NSURLRequestCachePolicy.ReturnCacheDataElseLoad
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            SVProgressHUD.dismiss()
            
            if (error != nil) {
                self.errorMessage.hidden = false
            } else {
                var errorValue: NSError? = nil
            
                let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as? NSDictionary
                self.movies = json!["movies"] as? NSArray
                self.tableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (movies != nil) {
            return movies!.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? MovieTableViewCell
        
        cell!.movie = movies![indexPath.row] as? NSDictionary

        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // tableView deselectRowAtIndexPath:indexPath animated:YES
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var vc = segue.destinationViewController as MovieDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as UITableViewCell)
        vc.movie = movies![indexPath!.row] as? NSDictionary
    }
    
    @IBAction func handleTap(sender: AnyObject) {
        errorMessage.hidden = true
    }
}

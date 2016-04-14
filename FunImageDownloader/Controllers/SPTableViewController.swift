//
//  SPTableViewController.swift
//  FunImageDownloader
//
//  Created by popovychs on 14.04.16.
//  Copyright © 2016 popovychs. All rights reserved.
//

import UIKit

class SPTableViewController: UITableViewController {
    
    let imagesLinks = ["http://worth1000.s3.amazonaws.com/submissions/555000/555068_fc7b.jpg",
                       "http://www.worldfortravel.com/wp-content/uploads/2012/06/The-Colosseum-Airiel-View.jpg",
                       "https://theyoungastronomer.files.wordpress.com/2012/08/img_2340.jpg",
                       "http://cervinis.com.p8.hostingprod.com/cusphotos/files/Cfakepath00205-09mustang-concept-ram-air-hood01356552182.jpg",
                       "http://moritzdressel.com/wp-content/uploads/2015/08/pyramid-1202350.jpg",
                       "http://dao27ppzr58tl.cloudfront.net/wp-content/uploads/2014/05/Steve-Wozniak.jpg",
                       "https://stefanhorrer.files.wordpress.com/2012/06/dscf1776.jpg",
                       "https://illmakeitmyself.files.wordpress.com/2011/10/img_9257.jpg",
                       "http://static.panoramio.com/photos/original/61127236.jpg",
                       "http://howibecametexan.com/wp-content/uploads/2013/10/IMG_9416.jpg",
                       "http://static.businessinsider.com/image/560a92f1dd089545578b4684/image.jpg",
                       "http://www.hybridwriter.com/wp-content/uploads/2013/09/IMG_0162.jpg",
                       "http://nosade.com/wp-content/uploads/Sunrise-Sea-of-sands-Erg-Chebbi-Merzouga-Sahara-desert_Source-NOSADE1.jpg",
                       "https://trinitraveller.files.wordpress.com/2011/03/golden.jpg",
                       "http://holidaying.in/wp-content/uploads/2013/12/istanbul.jpg",
                       "https://whoassite.files.wordpress.com/2012/01/namibia-2011-046.jpg",
                       "https://upload.wikimedia.org/wikipedia/commons/1/1c/Lw%C3%B3w_-_Rynek_01.JPG",
                       "https://upload.wikimedia.org/wikipedia/commons/b/b4/StanfordUniversityFootballOffense2007.jpg",
                       "https://stargzrblog.files.wordpress.com/2013/04/dscn0817.jpg",
                       "http://pureafrica.com.au/wp-content/uploads/victoria-falls-canyon-view.jpg",
                       "http://dorian.derobert.free.fr/blog/images/TDM_chine/IMG_3766.JPG"]
    
    let imagesNames = ["Eiffel Tower","Coliseum","Moon","Mustang","Pyramids of Giza","Steve Wozniak","Running","Apple","Uzhhorod","Pikachu Car","Steve Jobs","Stonehenge","Sahara","Japan","Istanbul","Horses","Lviv","Football","El Capitan","Victoria Falls","Great Wall"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Fun Image Downloader"
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesLinks.count
    }

//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
//
//         Configure the cell...
//
//        return cell
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

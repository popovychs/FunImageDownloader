//
//  SPTableViewController.swift
//  FunImageDownloader
//
//  Created by popovychs on 14.04.16.
//  Copyright © 2016 popovychs. All rights reserved.
//

import UIKit

var currentIndexPath : NSIndexPath?

class SPTableViewController: UITableViewController, DelegateProtocolCell, NSURLSessionDelegate {
    
    // MARK - Properties
    
    var downloadProgress = [Float](count: 21, repeatedValue: 0.0)
    
    var model = [SPModel]()
    
    // MARK - Our sourse of data
    
    let imagesLinksAndNames = ["Eiffel Tower" : "http://worth1000.s3.amazonaws.com/submissions/555000/555068_fc7b.jpg",
                               "Coliseum" : "http://www.worldfortravel.com/wp-content/uploads/2012/06/The-Colosseum-Airiel-View.jpg",
                               "Moon" : "https://theyoungastronomer.files.wordpress.com/2012/08/img_2340.jpg",
                               "Mustang" : "http://cervinis.com.p8.hostingprod.com/cusphotos/files/Cfakepath00205-09mustang-concept-ram-air-hood01356552182.jpg",
                       "Pyramids of Giza" : "http://moritzdressel.com/wp-content/uploads/2015/08/pyramid-1202350.jpg",
                       "Steve Wozniak" : "http://dao27ppzr58tl.cloudfront.net/wp-content/uploads/2014/05/Steve-Wozniak.jpg",
                       "Running" : "https://stefanhorrer.files.wordpress.com/2012/06/dscf1776.jpg",
                       "Apple" : "https://illmakeitmyself.files.wordpress.com/2011/10/img_9257.jpg",
                       "Uzhhorod" : "http://static.panoramio.com/photos/original/61127236.jpg",
                       "Pikachu Car" : "http://howibecametexan.com/wp-content/uploads/2013/10/IMG_9416.jpg",
                       "Steve Jobs" : "http://static.businessinsider.com/image/560a92f1dd089545578b4684/image.jpg",
                       "Stonehenge" : "http://www.hybridwriter.com/wp-content/uploads/2013/09/IMG_0162.jpg",
                       "Sahara" : "http://nosade.com/wp-content/uploads/Sunrise-Sea-of-sands-Erg-Chebbi-Merzouga-Sahara-desert_Source-NOSADE1.jpg",
                       "Japan" : "https://trinitraveller.files.wordpress.com/2011/03/golden.jpg",
                       "Istanbul" : "http://holidaying.in/wp-content/uploads/2013/12/istanbul.jpg",
                       "Horses" : "https://whoassite.files.wordpress.com/2012/01/namibia-2011-046.jpg",
                       "Lviv" : "https://upload.wikimedia.org/wikipedia/commons/1/1c/Lw%C3%B3w_-_Rynek_01.JPG",
                       "Football" : "https://upload.wikimedia.org/wikipedia/commons/b/b4/StanfordUniversityFootballOffense2007.jpg",
                       "El Capitan" : "https://stargzrblog.files.wordpress.com/2013/04/dscn0817.jpg",
                       "Victoria Falls" : "http://pureafrica.com.au/wp-content/uploads/victoria-falls-canyon-view.jpg",
                       "Great Wall" : "http://dorian.derobert.free.fr/blog/images/TDM_chine/IMG_3766.JPG"]

    // MARK: - Initialize Data Model
    
    func setModel(dictionary: [String:String]) -> [SPModel] {
        
        for (key, value) in dictionary{
            model.append(SPModel(name: key, link: value))
        }
        return model
    }
    
    // MARK: - Table View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Fun Image Downloader"
        
        model = setModel(imagesLinksAndNames)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SPTableViewCell
        
        let modelItem = model[indexPath.row]
        
        cell.cellDelegate = self
        
        cell.imageName.text = modelItem.name
        cell.cellImageLikn = modelItem.link
        
        cell.progressBar.setProgress(0, animated: true)
        cell.progressBar.progress = downloadProgress[indexPath.row]
        
        if modelItem.image != nil{
            cell.imagePreview.image = modelItem.image
        } else {
            cell.imagePreview.image = UIImage(named: "no-image.jpeg")
        }
        
        return cell
    }
    
    func didTabButtonWithCell(cell: SPTableViewCell){
        
        let urlString = NSURL(string: cell.cellImageLikn!)
        
        currentIndexPath = self.tableView.indexPathForCell(cell)
        
        print("\(currentIndexPath)")
        
        downloadImage(urlString!)
    }
    
    // MARK: - Download Image Func
    
    func getDataFromUrl(url: NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in completion(data: data, response: response, error: error)}.resume()
    }
    
    func downloadImage(url: NSURL) {
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                
                self.model[(currentIndexPath?.row)!].image = UIImage(data: data)
                print("Image set in model")
                
                // Reload cell!
                self.tableView.reloadRowsAtIndexPaths([currentIndexPath!], withRowAnimation: .None)
            }
        }
    }
    
    // MARK - ProgressView
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64){
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.downloadProgress[(currentIndexPath?.row)!] = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
            
            var cell = self.tableView.cellForRowAtIndexPath(currentIndexPath!)
            
            
            print("\(self.downloadProgress[(currentIndexPath?.row)!])")
            
        }
    }

    // MARK: - Navigation to Detail View

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let segueIdentifier = "ShowDetails"
        
        if segue.identifier == segueIdentifier {
            if let destination = segue.destinationViewController as? DetailViewController {
                if let cellIndex = tableView.indexPathForSelectedRow?.row {
                    destination.detailNameLabelSegue = model[cellIndex].name
                    if model[cellIndex].image != nil {
                        destination.detailImageFromSegue = model[cellIndex].image
                    }
                }
            }
        }
    }
    
}

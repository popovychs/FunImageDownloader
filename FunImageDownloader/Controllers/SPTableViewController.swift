//
//  SPTableViewController.swift
//  FunImageDownloader
//
//  Created by popovychs on 14.04.16.
//  Copyright © 2016 popovychs. All rights reserved.
//

import UIKit

var currentIndexPath : NSIndexPath?

class SPTableViewController: UITableViewController, DelegateProtocolCell {
    
    // MARK: Create Session and Initialize with Default Session Config
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    // MARK - Models
    
    var activeDownloads = [String : SPDownloadManager]()
    
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
    
    lazy var downloadsSession: NSURLSession = {
        let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("bgSessionConfiguration")
        let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        return session
    }()
    
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
        
        //var showDownloadControls = false
        if let download = activeDownloads[cell.cellImageLikn!] {
            //showDownloadControls = true
            
            cell.progressBar.progress = download.downloadProgresss
            
            let title = (download.isDownloading) ? "CANCEL" : "START"
            cell.myButton.setTitle(title, forState: UIControlState.Normal)
        }
        
        if modelItem.image != nil{
            cell.imagePreview.image = modelItem.image
        } else {
            cell.imagePreview.image = UIImage(named: "no-image.jpeg")
        }
        
        return cell
    }
    
    // MARK: Download methods
    
    // Called when the Download button for a track is tapped
    func startDownload(model: SPModel) {
        
        if let urlString = model.link, url =  NSURL(string: urlString) {

            let download = SPDownloadManager(url: urlString)

            download.downloadTask = downloadsSession.downloadTaskWithURL(url)

            download.downloadTask!.resume()

            download.isDownloading = true

            activeDownloads[download.url] = download
            
        }
    }
    
    // MARK: - Cancel Download Image
    
    func cancelDownloadImage(cell: SPTableViewCell) {
        
        if let urlString = cell.cellImageLikn,
            download = activeDownloads[urlString] {
            download.downloadTask?.cancel()
            activeDownloads[urlString] = nil
        }
    }
    
    func downloadImage(cell: SPTableViewCell) {
        if let indexPath = tableView.indexPathForCell(cell) {
            let image = model[indexPath.row]
            startDownload(image)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .None)
        }
    }
    
    // MARK: Download helper methods
    
    // This method generates a permanent local file path to save a track to by appending
    // the lastPathComponent of the URL (i.e. the file name and extension of the file)
    // to the path of the app’s Documents directory.
    func localFilePathForUrl(previewUrl: String) -> NSURL? {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        if let url = NSURL(string: previewUrl), lastPathComponent = url.lastPathComponent {
            let fullPath = documentsPath.stringByAppendingPathComponent(lastPathComponent)
            return NSURL(fileURLWithPath:fullPath)
        }
        return nil
    }
    
    // This method checks if the local file exists at the path generated by localFilePathForUrl(_:)
    func localFileExistsForTrack(model: SPModel) -> Bool {
        if let urlString = model.link, localUrl = localFilePathForUrl(urlString) {
            var isDir : ObjCBool = false
            if let path = localUrl.path {
                return NSFileManager.defaultManager().fileExistsAtPath(path, isDirectory: &isDir)
            }
        }
        return false
    }
    
    func trackIndexForDownloadTask(downloadTask: NSURLSessionDownloadTask) -> Int? {
        if let url = downloadTask.originalRequest?.URL?.absoluteString {
            for (index, image) in model.enumerate() {
                if url == image.link {
                    return index
                }
            }
        }
        return nil
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

// MARK: - NSURLSessionDelegate

extension SPTableViewController: NSURLSessionDelegate {
    
    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            if let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler()
                })
            }
        }
    }
}

// MARK: - NSURLSessionDownloadDelegate

extension SPTableViewController: NSURLSessionDownloadDelegate {
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        let data = NSData(contentsOfURL: location)
        let image = UIImage(data: data!)
        
        if let trackIndex = trackIndexForDownloadTask(downloadTask) {
            dispatch_async(dispatch_get_main_queue(), {
                self.model[trackIndex].image = image
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: trackIndex, inSection: 0)], withRowAnimation: .None)
            })
        }
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        // 1
        if let downloadUrl = downloadTask.originalRequest?.URL?.absoluteString,
            download = activeDownloads[downloadUrl] {
            
            download.downloadProgresss = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
            
            if let trackIndex = trackIndexForDownloadTask(downloadTask), let trackCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: trackIndex, inSection: 0)) as? SPTableViewCell {
                dispatch_async(dispatch_get_main_queue(), {
                    trackCell.progressBar.progress = download.downloadProgresss
                    trackCell.progressCount.text =  String(format: "%.1f%% ",  download.downloadProgresss * 100)
                })
            }
        }
    }

}

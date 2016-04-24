//
//  SPDownloadManager.swift
//  FunImageDownloader
//
//  Created by popovychs on 23.04.16.
//  Copyright © 2016 popovychs. All rights reserved.
//

import UIKit

class SPDownloadManager {
    
    var url : String
    var isDownloading = false
    var downloadProgresss : Float = 0.0
    
    var downloadTask : NSURLSessionDownloadTask?
    var resumeData : NSData?
    
    init(url: String) {
        self.url = url
    }

}
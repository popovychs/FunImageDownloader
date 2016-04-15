//
//  SPModel.swift
//  FunImageDownloader
//
//  Created by popovychs on 15.04.16.
//  Copyright © 2016 popovychs. All rights reserved.
//

import UIKit

class SPModel {
    
    // MARK - Properties
    
    var name : String
    var link : String
    var image : UIImage?
 
    // MARK - Initialization
    
    init(name: String, link: String, image: UIImage?){
        self.name = name
        self.link = link
        self.image = image
    }
}
//
//  DetailViewController.swift
//  FunImageDownloader
//
//  Created by popovychs on 18.04.16.
//  Copyright © 2016 popovychs. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailNameLabel: UILabel!
    
    var viaSegue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailNameLabel.text = viaSegue
    }
}

//
//  DetailViewController.swift
//  FunImageDownloader
//
//  Created by popovychs on 18.04.16.
//  Copyright © 2016 popovychs. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailNameLabel: UILabel!
    
    // MARK: - Properties
    
    var detailNameLabelSegue = ""
    var detailImageFromSegue : UIImage?
    
    // MARK: - Methods
    
    override func viewWillAppear(animated: Bool) {
        
        detailNameLabel.text = detailNameLabelSegue
        
        if detailImageFromSegue != nil {
            detailImageView.image = detailImageFromSegue
        }
    }
    
}

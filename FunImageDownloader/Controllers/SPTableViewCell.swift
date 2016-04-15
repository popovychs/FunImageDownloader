//
//  SPTableViewCell.swift
//  FunImageDownloader
//
//  Created by popovychs on 14.04.16.
//  Copyright © 2016 popovychs. All rights reserved.
//

import UIKit

class SPTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet var imagePreview: UIImageView!
    @IBOutlet var imageName: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var percentsProgressLabel: UILabel!
    
    // MARK: - Functions

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressButton(sender: AnyObject) {
        
    }

}

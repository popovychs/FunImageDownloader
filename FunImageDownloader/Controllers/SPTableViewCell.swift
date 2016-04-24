//
//  SPTableViewCell.swift
//  FunImageDownloader
//
//  Created by popovychs on 14.04.16.
//  Copyright © 2016 popovychs. All rights reserved.
//

import UIKit

protocol DelegateProtocolCell {
    func downloadImage(cell: SPTableViewCell)
    func cancelDownloadImage(cell: SPTableViewCell)
}

class SPTableViewCell: UITableViewCell {
    
    // MARK: - Delegate Property
    
    var cellDelegate : DelegateProtocolCell? = nil
    
    // MARK: - Outlets
    
    @IBOutlet var imagePreview: UIImageView!
    @IBOutlet var imageName: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var progressCount: UILabel!
    @IBOutlet var myButton: UIButton!
    
    // MARK: - Properties
    
    var cellImageLikn : String?
    
    // MARK: - Costumize cell

    override func awakeFromNib() {
        super.awakeFromNib()
        myButton.layer.cornerRadius = 3
    }
    
    // MARK: - Button Delegate
    
    @IBAction func pressButton(sender: AnyObject) {
        
        myButton.setTitle(" STOP ", forState: .Normal)
        
        if(myButton.titleLabel!.text == " STOP ") {
            cellDelegate?.cancelDownloadImage(self)
        } else {
            cellDelegate?.downloadImage(self)
        }
    
    }

}

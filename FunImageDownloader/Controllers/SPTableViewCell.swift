//
//  SPTableViewCell.swift
//  FunImageDownloader
//
//  Created by popovychs on 14.04.16.
//  Copyright © 2016 popovychs. All rights reserved.
//

import UIKit

protocol DelegateProtocolCell {
    func didTabButtonWithCell(cell: SPTableViewCell)
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
    
    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func pressButton(sender: AnyObject) {
        
        myButton.setTitle(" STOP ", forState: .Normal)

        if (cellDelegate != nil) {
            cellDelegate?.didTabButtonWithCell(self)
        }
    }

}

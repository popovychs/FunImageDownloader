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
    
    // MARK: Delegate Property
    
    var cellDelegate : DelegateProtocolCell? = nil
    
    // MARK: - Properties
    
    @IBOutlet var imagePreview: UIImageView!
    @IBOutlet var imageName: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var percentsProgressLabel: UILabel!
    @IBOutlet var myButton: UIButton!
    
    var cellImageLikn : String?
    
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
        
        myButton.setTitle(" STOP ", forState: .Normal)

        if (cellDelegate != nil) {
            cellDelegate?.didTabButtonWithCell(self)
        }
    }

}

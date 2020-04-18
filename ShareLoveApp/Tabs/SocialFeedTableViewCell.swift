//
//  SocialFeedTableViewCell.swift
//  ShareLoveApp
//
//  Created by GreenyAu on 4/5/20.
//

import UIKit

class SocialFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var action: UILabel!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var photo: UIImageView!{
        didSet {
            photo.layer.cornerRadius = photo.bounds.width / 2
            photo.clipsToBounds = true
            photo.layer.borderColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 1.00).cgColor
            photo.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var redLine: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

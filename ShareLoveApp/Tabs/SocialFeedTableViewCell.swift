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
    @IBOutlet weak var photo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

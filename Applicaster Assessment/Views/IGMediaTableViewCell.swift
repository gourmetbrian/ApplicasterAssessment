//
//  IGMediaTableViewCell.swift
//  Applicaster Assessment
//
//  Created by Brian Lane on 10/22/19.
//  Copyright © 2019 Brian Lane. All rights reserved.
//

import UIKit

class IGMediaTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameHeader: UILabel!
    @IBOutlet weak var usernameFooter: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var avatarImage: AsyncLoadableImageView!
    @IBOutlet weak var igImage: AsyncLoadableImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(with model: IGMediaModel) {
        igImage.loadImage(with: model.mediaURL)
        avatarImage.loadImage(with: model.userAvatar)
        usernameFooter.text = model.user
        usernameHeader.text = model.user
        caption.text = model.caption
        
    }
    
}

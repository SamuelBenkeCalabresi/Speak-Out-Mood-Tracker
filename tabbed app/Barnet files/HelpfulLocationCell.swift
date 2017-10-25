//  Speak Out!
//
//  Created by admin on 22/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.

import UIKit

class HelpfulLocationCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 1
        let layoutGuide = UILayoutGuide()
        contentView.addLayoutGuide(layoutGuide)
        
        // 2
        let topConstraint = layoutGuide.topAnchor
            .constraint(equalTo: nameLabel.topAnchor)
        
        // 3
        let bottomConstraint = layoutGuide.bottomAnchor
            .constraint(equalTo: locationNameLabel.bottomAnchor)
        
        // 4
        let centeringConstraint = layoutGuide.centerYAnchor
            .constraint(equalTo: contentView.centerYAnchor)
        
        // 5
        NSLayoutConstraint.activate(
            [topConstraint, bottomConstraint, centeringConstraint])
    }
}

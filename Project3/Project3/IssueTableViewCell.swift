//
//  IssueTableViewCell.swift
//  Project3
//
//  Created by Yangjun Bie on 1/26/20.
//  Copyright © 2020 Yangjun Bie. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {
    @IBOutlet var tableImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

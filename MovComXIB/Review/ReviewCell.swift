//
//  ReviewCell.swift
//  MovComXIB
//
//  Created by Ivan on 22/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var reviewContent: UILabel!
    @IBOutlet weak var authorName   : UILabel!
    var name                        : String!
    var content                     : String!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

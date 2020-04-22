//
//  movieCell.swift
//  MovComXIB
//
//  Created by Ivan on 22/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import UIKit

class movieCell: UICollectionViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    func configCell(_ movie: Result?){
        cardView(view: moviePoster, radius: 10)
        let imgPath = (movie?.posterPath ?? "").isEmpty ? "/7W0G3YECgDAfnuiHG91r8WqgIOe.jpg" : movie?.posterPath!
        let urls = Constants.imageHost+imgPath!
        
        moviePoster.sd_setImage(with: URL(string: urls))
        movieName.text = movie?.title
    }

}

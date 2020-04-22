//
//  genreCell.swift
//  MovComXIB
//
//  Created by Ivan on 21/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import UIKit

class genreCell: UICollectionViewCell {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var genreView: UIView!
    @IBOutlet weak var genreNames: UILabel!
    private var genre: GenreModel?
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func configCell(_ genre: GenreModel?, index: Int){
        
        cardView(view: genreView, radius: 10)
        UIGraphicsBeginImageContext(genreView.frame.size)
        var image = UIImage(named: Constants.genreImage[index])
        image?.draw(in: genreView.bounds)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        genreView.backgroundColor = UIColor(patternImage: image!)

        genreNames?.text = genre?.name
        overlayView.backgroundColor = UIColor(red:0.26, green:0.26, blue:0.26, alpha:0.70)
        cardView(view: overlayView, radius: 10)
    }
}

extension UICollectionViewCell{
    func cardView(view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
    }
}

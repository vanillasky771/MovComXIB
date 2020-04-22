//
//  MovieDetailView.swift
//  MovComXIB
//
//  Created by Ivan on 22/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class MovieDetailView: UIViewController {

    var movieTitles  : String!
    var movieID     : Int!
    var voteAverage : Double!
    var popularity  : Double!
    var backdropPth : String!
    var posterPth   : String!
    var overviews   : String!
    var releaseDate : String!
    var items       : [TResult] = []
    
    @IBOutlet weak var trailerBtn: UIButton!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var watcherCount: UILabel!
    @IBOutlet weak var released: UILabel!
    @IBOutlet weak var movieTExt: UITextView!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchTrailer(movieID: movieID!)
    }
    @IBAction func trailerPlay(_ sender: Any) {
        let vc = TrailerView(nibName: "TrailerView", bundle: nil)
        vc.modalPresentationStyle = .pageSheet
        vc.videoKey = items[0].key.isEmpty ? items[0].key : items[0].key
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    @IBAction func openReview(_ sender: Any) {
        let vc = ReviewView(nibName: "ReviewView", bundle: nil)
        vc.modalPresentationStyle = .pageSheet
        vc.movIds = self.movieID
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
}
//MARK:- Setup UI
extension MovieDetailView {
    func setupUI(){
        movieName.text      = movieTitles
        movieRate.text      = String(voteAverage)
        watcherCount.text   = String(popularity)
        released.text       = releaseDate
        if (backdropPth != nil){
            backdropImage.sd_setImage(with: URL(string: Constants.imageHost+backdropPth))
        }else{
            backdropImage.sd_setImage(with: URL(string: Constants.imageHost+"/5BwqwxMEjeFtdknRV792Svo0K1v.jpg"))
        }
        if(posterPth != nil){
            posterImage.sd_setImage(with: URL(string: Constants.imageHost+posterPth))
        }else{
            posterImage.sd_setImage(with: URL(string: Constants.imageHost+"/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg"))
        }
        movieTExt.backgroundColor = UIColor.clear
    }
    func fetchTrailer(movieID: Int){
        let url = Constants.host+"movie/\(movieID)/videos?api_key=765f90b887428e11c9c3f8439cd80f8b&language=en-US"
        AF.request(url)
        .validate()
        .responseDecodable(of: Trailer.self) { (data) in
          guard let films = data.value else { print(data.error!)
            return }
            self.items = films.results
            if self.items.count == 0{
               self.trailerBtn.isHidden = true
            }
        }
    }
}

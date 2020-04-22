//
//  MovieView.swift
//  MovComXIB
//
//  Created by Ivan on 21/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class MovieView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var loadingMovie: UIActivityIndicatorView!
    @IBOutlet weak var movieList: UICollectionView!
    @IBOutlet weak var genreNameDisplay: UILabel!
    var movieID     : Int!
    var movieGenre  : String!
    var pageCount   = 1
    var items       = [Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingMovie.startAnimating()
        setupUI()
    }
}

//MARK:- View Setup
extension MovieView {
    func setupUI(){
        genreNameDisplay.text = movieGenre
        let nib = UINib(nibName: "movieCell", bundle: nil)
        movieList.register(nib, forCellWithReuseIdentifier: "movieCell")
        movieList.backgroundColor = .clear
        movieList.dataSource = self
        movieList.delegate = self
        movieList.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        movieList.infiniteScrollIndicatorMargin = 40
        movieList.addInfiniteScroll {[weak self] (scrollView) -> Void in
            self?.fetchMovie({
                scrollView.finishInfiniteScroll()
                self?.loadingMovie.stopAnimating()
                self?.loadingMovie.isHidden = true
            })
        }
        movieList.beginInfiniteScroll(true)
    }
}
//MARK:- CollectionView DataSource
extension MovieView {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? movieCell else { fatalError() }
        let movie = items[indexPath.item]
        cell.configCell(movie)
        return cell
    }
}

//MARK:- CollectionView Delegate
extension MovieView{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailView(nibName: "MovieDetailView", bundle: nil)
        vc.modalPresentationStyle = .pageSheet
        vc.movieTitles      = items[indexPath.row].title
        vc.movieID          = items[indexPath.row].id
        vc.voteAverage      = items[indexPath.row].voteAverage
        vc.popularity       = items[indexPath.row].popularity
        vc.backdropPth      = items[indexPath.row].backdropPath
        vc.posterPth        = items[indexPath.row].posterPath
        vc.overviews        = items[indexPath.row].overview
        vc.releaseDate      = items[indexPath.row].releaseDate
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
}

//MARK:- Fetch Data
extension MovieView {
    func fetchMovie(_ completionHandler:(() -> Void)?){
        fetchData { (result) in
            switch result {
            case .ok(let response):
                let newItems = response.results
                let count = self.items.count
                let (start, end) = (count, newItems.count + count)
                let indexPath = (start..<end).map {return IndexPath(row: $0, section: 0)}
                self.items.append(contentsOf: newItems)
                self.movieList.performBatchUpdates({() -> Void in
                    self.movieList.insertItems(at: indexPath)
                }, completion: {(finished) -> Void in
                    completionHandler?()
                    self.pageCount = self.pageCount + 1
                })
            case .error(let error):
                print(error)
            }
        }
    }
    
    typealias FetchResult = Results<Movie,FetchError>
    
    func makeReq(id: Int, page: Int) -> URLRequest{
        let url = URL(string: Constants.host+"discover/movie?language=en-US&include_adult=false&page=\(page)&api_key=765f90b887428e11c9c3f8439cd80f8b&include_video=true&with_original_language=en&with_genres=\(id)")!
        return URLRequest(url: url)
    }
    func fetchData(handler: @escaping ((FetchResult) -> Void)){
        let request = makeReq(id: movieID, page: pageCount)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, _, Err) -> Void in
            DispatchQueue.main.async {
                handler(handleFetchResponse(data: data, networkError: Err))
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            task.resume()
        })
        
    }
}

extension MovieView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        let itemWidth = collectionWidth / 2 - 11
        let itemHeight = collectionWidth - 57
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

//
//  HomeView.swift
//  MovComXIB
//
//  Created by Ivan on 21/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import UIKit
import Alamofire

class HomeView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var genreCollectionView: UICollectionView!
    var presenter: genrePresentation?
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        presenter?.loadGenre()
    }

}

extension HomeView: genreViewInterface{
    func refreshGenreList() {
        self.genreCollectionView.reloadData()
    }
    
    func showLoadingError(errorMessage: String) {
        let alert = UIAlertController(title: "Attention", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK:- View Setups
extension HomeView: UICollectionViewDelegateFlowLayout {
    func setupUI(){
        let nib = UINib(nibName: "genreCell", bundle: nil)
        self.genreCollectionView.register(nib, forCellWithReuseIdentifier: "genreCell")
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        genreCollectionView.backgroundColor = .clear
        genreCollectionView.showsVerticalScrollIndicator = false
        genreCollectionView.showsHorizontalScrollIndicator = false
    }
    //MARK:- CollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.sections ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.genreCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as? genreCell else { fatalError() }
        
        let genre = presenter?.genre(at: indexPath.item)
        cell.configCell(genre, index: indexPath.row)
        return cell
    }
    //MARK:- CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let genre = presenter?.genre(at: indexPath.item){
            presenter?.selectGenre(genre)
        }
        
    }
    //MARK:- CollectionView FlowDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 280)
    }
    
}

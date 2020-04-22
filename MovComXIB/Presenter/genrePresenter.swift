//
//  genrePresenter.swift
//  MovComXIB
//
//  Created by Ivan on 21/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import Foundation

protocol genrePresentation: class {
    var sections    : Int { get }
    var genreCount  : Int { get }
    func genre(at Index: Int) -> GenreModel?
    func selectGenre(_ genre: GenreModel)
    func loadGenre()
}

//MARK:- Presenter -> View Interface
protocol genreViewInterface: class {
    func refreshGenreList()
    func showLoadingError(errorMessage: String)
}

//Mark:- Presenter
class GenrePresenter: genrePresentation {
    
    
    //MARK:- Init
    private var interactor      : genreInteraction
    private var router          : genreRouting
    weak var viewInterface   : genreViewInterface?
    init(interactor: genreInteraction, router: genreRouting){
        self.interactor = interactor
        self.router = router
    }
    
    private(set) var Genres: [GenreModel]?{
        didSet{
            guard let _ = Genres, !Genres!.isEmpty else {
                return
            }
            viewInterface!.refreshGenreList()
        }
    }
    
    //MARK:- Logic
    var sections: Int {
        return 1
    }
    var genreCount : Int {
        return Genres?.count ?? 0
    }
    func loadGenre() {
        interactor.fetchGenre()
    }
    func genre(at Index: Int) -> GenreModel? {
        return Genres?[Index] ?? nil
    }
    func selectGenre(_ genre: GenreModel) {
        router.presentMovieList(with: genre)
    }
}

extension GenrePresenter: genreInteractionOutput{

    func refreshGenre(with genre: [GenreModel]) {
        self.Genres = genre
    }
    
    func genreFetchedFailed() {
        viewInterface?.showLoadingError(errorMessage: "Some Error Occured")
    }
    
    
}

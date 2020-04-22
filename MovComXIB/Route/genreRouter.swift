//
//  genreRouter.swift
//  MovComXIB
//
//  Created by Ivan on 21/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import Foundation
import UIKit

protocol genreRouting: class {
    func presentMovieList(with genre: GenreModel)
}


class GenreRouter: genreRouting {
    
    func presentMovieList(with genre: GenreModel) {
        let vc = MovieView(nibName: "MovieView", bundle: nil)
        vc.modalPresentationStyle = .pageSheet
        vc.movieID = genre.id
        vc.movieGenre = genre.name
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
}

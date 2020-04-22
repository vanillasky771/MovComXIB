//
//  GenreDependencyContainer.swift
//  MovComXIB
//
//  Created by Ivan on 21/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import UIKit

class GenreDependecyContainer {
    lazy var interactor = GenreInteractor()
    lazy var router     = GenreRouter()
    lazy var presenters  = GenrePresenter(interactor: interactor, router: router)
    
    func makeGenreView() -> HomeView {
        let viewController = HomeView()
        
        viewController.presenter = presenters
        presenters.viewInterface = viewController as genreViewInterface
        interactor.presenter = presenters
        return viewController
    }
}

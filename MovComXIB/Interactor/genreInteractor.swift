//
//  genreInteractor.swift
//  MovComXIB
//
//  Created by Ivan on 21/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import Foundation
import Alamofire

//MARK:- Interaction Protocol
protocol genreInteraction {
    func fetchGenre()
}
//MARK:- Interaction -> Presenter Protocol
protocol genreInteractionOutput: class {
    var Genres : [GenreModel]? { get }
    func refreshGenre(with genre: [GenreModel])
    func genreFetchedFailed()
}

//MARK: - Interactor
class GenreInteractor: genreInteraction {
    var presenter: genreInteractionOutput?
    func fetchGenre() {
        AF.request(Constants.host+"genre/movie/list?api_key=765f90b887428e11c9c3f8439cd80f8b&language=en-US").response { response in
            if(response.response?.statusCode == 200){
                guard let data = response.data else { return }
                do{
                    let decoder = JSONDecoder()
                    let genreResponse = try decoder.decode(GenreResponse.self, from: data)
                    guard let items = genreResponse.genres else{ return }
                    self.presenter?.refreshGenre(with: items)
                } catch let error {
                    print(error)
                }
            } else {
                self.presenter?.genreFetchedFailed()
            }
        }
    }
}

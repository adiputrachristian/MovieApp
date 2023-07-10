//
//  MovieHomeInteractor.swift
//  MovieApp
//
//  Created Christian Adiputra on 23/06/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import NetworkKit

class MovieHomeInteractor {
    weak var presenter: MovieHomeInteractorOutputProtocol?
    let movieService: MovieServiceProtocol = MovieService()
    
    var listGenre: [MovieGenre] = []
    var listDiscover: [Movie] = []
}


extension MovieHomeInteractor: MovieHomeInteractorProtocol {
    
    func fetchDiscoverMovies() {
        movieService.getListDiscover(page: 1, genre: nil) { [weak self] response in
            guard let movies = response.result else { return }
            self?.listDiscover = movies
            self?.presenter?.didSuccessGetDiscover()
        } onFailure: { error in
            self.presenter?.didFailedFetchData(message: error.localizedDescription)
        }
    }
    
}

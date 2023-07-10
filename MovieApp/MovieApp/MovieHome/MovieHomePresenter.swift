//
//  MovieHomePresenter.swift
//  MovieApp
//
//  Created by Christian Adiputra on 23/06/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import NetworkKit

final class MovieHomePresenter {
    
    weak private var view: MovieHomeViewProtocol?
    private var interactor: MovieHomeInteractorProtocol?
    private var wireframe: MovieHomeRouterProtocol?
    
    var randomMovie: Movie?
    
    init(view: MovieHomeViewProtocol, 
         interactor: MovieHomeInteractorProtocol, 
         wireframe: MovieHomeRouterProtocol) {

        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        fetchDiscoverMovies()
    }
    
}

extension MovieHomePresenter: MovieHomePresenterProtocol {
    func getListDiscover() -> [Movie] {
        guard let movies = interactor?.listDiscover else { return [] }
        return movies
    }
    
    func getRandomPoster() -> URL? {
        guard let movie = randomMovie else { return URL(string: "") }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        return url
    }
    
    func getRandomMovie() {
        guard let movies = interactor?.listDiscover, movies.count != 0 else { return }
        let randomInt = Int(arc4random_uniform(UInt32(movies.count)))
        randomMovie = movies[randomInt]
    }
    
    func fetchDiscoverMovies() {
        interactor?.fetchDiscoverMovies()
    }
    
    func goToListMovie() {
        wireframe?.goToListMovie()
    }
    
    func goToDetailMovie(movieId: Int) {
        wireframe?.goToDetailMovie(movieId: movieId)
    }
}

extension MovieHomePresenter: MovieHomeInteractorOutputProtocol {
    func didFailedFetchData(message: String) {
        view?.showAlert(message: message)
    }
    
    func didSuccessGetDiscover() {
        getRandomMovie()
        view?.updateList()
    }
    

    
    
}

//
//  ListMoviePresenter.swift
//  MovieApp
//
//  Created by Christian Adiputra on 01/07/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import NetworkKit

final class ListMoviePresenter {

    // MARK: - Private properties -

    private let view: ListMovieViewInterface
    private let interactor: ListMovieInteractorInterface
    private let wireframe: ListMovieWireframeInterface
    
    var page: Int = 1

    // MARK: - Lifecycle -

    init(
        view: ListMovieViewInterface,
        interactor: ListMovieInteractorInterface,
        wireframe: ListMovieWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        fetchDiscoverMovies()
        fetchListGenre()
    }
}

// MARK: - Extensions -


extension ListMoviePresenter: ListMoviePresenterInterface {
    func getTotalPages() -> Int {
        return interactor.totalPages ?? 0
    }
    
    func setFilter(filter: [MovieGenre]) {
        
        if interactor.selectedGenre != filter {
            interactor.selectedGenre = filter
            interactor.listDiscover.removeAll()
            self.page = 1
            view.scrollToTop()
        }
    
        interactor.fetchDiscoverMovies(page: page)
    }
    
    func fetchListGenre() {
        interactor.fetchListGenre()
    }
    
    func getListGenre() -> [MovieGenre] {
        return interactor.listGenre
    }
    
    func getListSelectedGenre() -> [MovieGenre] {
        return interactor.selectedGenre
    }
    
    func goToDetailMovie(movieId: Int) {
        wireframe.goToDetailMovie(movieId: movieId)
    }
    
    func getListDiscover() -> [Movie] {
        let movies = interactor.listDiscover
        return movies
    }
    
    func getRandomPoster() -> URL? {
        let movies = interactor.listDiscover
        let randomInt = Int(arc4random_uniform(UInt32(movies.count)))
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movies[randomInt].posterPath)")
        return url
    }
    
    func fetchDiscoverMovies() {
        interactor.fetchDiscoverMovies(page: self.page)
    }
    
    func addPage() {
        self.page += 1
    }
    
}

extension ListMoviePresenter: ListMovieOutputInteractorInterface {
    func didFailedFetchData(message: String) {
        view.showAlert(message: message)
    }
    
    func didSuccessGetGenres() {}
    
    func didSuccessGetDiscover() {
        view.updateList()
    }
    
}
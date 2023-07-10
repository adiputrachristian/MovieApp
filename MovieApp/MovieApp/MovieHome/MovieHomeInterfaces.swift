//
//  MovieHomeInterfaces.swift
//  MovieApp
//
//  Created by Christian Adiputra on 23/06/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import DesignKit
import NetworkKit

protocol MovieHomeRouterProtocol: WireframeInterface {
    func goToListMovie()
    func goToDetailMovie(movieId: Int)
}

protocol MovieHomePresenterProtocol: PresenterInterface {
    var randomMovie: Movie? { get set }
    func goToListMovie()
    func goToDetailMovie(movieId: Int)
    func fetchDiscoverMovies()
    func getListDiscover() -> [Movie]
    func getRandomPoster() -> URL?
    func getRandomMovie()
}

protocol MovieHomeInteractorOutputProtocol: InteractorOutputInterface {
    func didSuccessGetDiscover()
    func didFailedFetchData(message: String)
}

protocol MovieHomeInteractorProtocol: InteractorInterface {
    func fetchDiscoverMovies()
    var listDiscover: [Movie] { get }
}

protocol MovieHomeViewProtocol: ViewInterface {
    func updateList()
    func showAlert(message: String)
}

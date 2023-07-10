//
//  MovieHomeWireframe.swift
//  MovieApp
//
//  Created by Christian Adiputra on 29/06/23.
//

import Foundation
import DesignKit

final class MovieHomeWireframe:
    BaseWireframe<MovieHomeViewController> {
    
    init() {
        let moduleViewController = MovieHomeViewController()
        super.init(viewController: moduleViewController)

        let interactor = MovieHomeInteractor()
        let presenter = MovieHomePresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        interactor.presenter = presenter
        moduleViewController.presenter = presenter
    }
    
}

extension MovieHomeWireframe: MovieHomeRouterProtocol {
    func goToListMovie() {
        navigationController?.pushWireframe(ListMovieWireframe())
    }
    
    func goToDetailMovie(movieId: Int) {
        navigationController?.pushWireframe(DetailMovieWireframe(movieId: movieId))
    }
    
    
}

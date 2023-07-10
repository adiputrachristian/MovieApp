//
//  MovieService.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 01/07/23.
//

import Foundation
import Moya

public class MovieService: MovieServiceProtocol, APIMappingProtocol {
    
    private let provider: BaseProvider<MovieProvider>
    
    public init(provider: BaseProvider<MovieProvider> = BaseProvider<MovieProvider>()) {
        self.provider = provider
    }
    
    
    public func getListGenres(onSuccess: ((ListGenres) -> Void)?, onFailure: ((Error) -> Void)?) {
        provider.request(.getListGenres) { [weak self] result in
            self?.handlePlainResult(result, typeResponse: ListGenres.self, onSuccess: onSuccess, onFailure: onFailure)
        }

    }
    
    public func getListDiscover(page: Int, genre: String?, onSuccess: ((BaseListModel<Movie>) -> Void)?, onFailure: ((Error) -> Void)?) {
        provider.request(.getDiscover(page: page, genres: genre)) { [weak self] result in
            self?.handleResultList(result, typeResponse: Movie.self, onSuccess: onSuccess, onFailure: onFailure)
        }
    }
    
    public func getDetailMovie(id: Int, onSuccess: ((Movie) -> Void)?, onFailure: ((Error) -> Void)?) {
        provider.request(.getDetailMovie(id: id)) { [weak self] result in
            self?.handlePlainResult(result, typeResponse: Movie.self, onSuccess: onSuccess, onFailure: onFailure)
        }
    }
    
    public func getListReview(page: Int, id: Int, onSuccess: ((BaseListModel<MovieReview>)->Void)?, onFailure: ((Error) -> Void)?) {
        provider.request(.getListReview(page: page, id: id)) { [weak self] result in
            self?.handleResultList(result, typeResponse: MovieReview.self, onSuccess: onSuccess, onFailure: onFailure)
        }
    }
        
}

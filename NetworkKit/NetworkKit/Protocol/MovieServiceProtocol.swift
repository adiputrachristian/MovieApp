//
//  MovieProtocol.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 01/07/23.
//

import Foundation
import Moya

public protocol MovieServiceProtocol {
    func getListGenres(onSuccess: ((ListGenres)->Void)?, onFailure: ((Error)->Void)?)
    func getListDiscover(page: Int, genre: String?, onSuccess: ((BaseListModel<Movie>)->Void)?, onFailure: ((Error)->Void)?)
    func getDetailMovie(id: Int, onSuccess: ((Movie)->Void)?, onFailure:((Error)->Void)?)
    func getListReview(page: Int, id: Int, onSuccess: ((BaseListModel<MovieReview>)->Void)?, onFailure: ((Error)->Void)?)
}

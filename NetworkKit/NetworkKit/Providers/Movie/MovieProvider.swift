//
//  MovieProvider.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 01/07/23.
//

import Foundation
import Moya

public enum MovieProvider {
    case getDiscover(page: Int, genres: String?)
    case getListGenres
    case getDetailMovie(id: Int)
    case getListReview(page: Int, id: Int)
}

extension MovieProvider: TargetType {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://api.themoviedb.org/3")!
        }
    }
    
    public var path: String {
        switch self {
        case .getListGenres:
            return "/genre/movie/list"
        case .getDetailMovie(let id):
            return "/movie/\(id)"
        case .getListReview(_, let id):
            return "/movie/\(id)/reviews"
        default:
            return "/discover/movie"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .getListReview(let page, _):
            return .requestParameters(
                parameters: [
                    "language": "en-US",
                    "page": page
                ],
                encoding: URLEncoding.default
            )
        case .getDetailMovie:
            return .requestParameters(
                parameters: [
                    "append_to_response" : "videos",
                    "language": "en-US"

                ],
                encoding: URLEncoding.default
            )
        case .getDiscover(let page, let genre):
            return .requestParameters(
                parameters: [
                    "language": "en-US",
                    "with_genres": genre ?? "",
                    "page": page,
                    "sort_by": "popularity.desc"
                ],
                encoding: URLEncoding.default
            )
        case .getListGenres:
            return .requestParameters(
                parameters: [
                    "language": "en"
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjY2RlYjA1NTA1MWJkYmE5ZTEwNmFlM2ViZmE4OGZhMCIsInN1YiI6IjY0NmM4MmJkNTRhMDk4MDBmZWFjZDcwYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XUY9JIH7wUpzFMuI-2OcVfx3QVTGguqkO91UbPLpk4s"
            ]
        }
    }
}



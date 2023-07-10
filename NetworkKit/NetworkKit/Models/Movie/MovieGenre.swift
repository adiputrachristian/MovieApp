//
//  MovieGenre.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 01/07/23.
//

import Foundation

public struct MovieGenre: NullableMap, Equatable {

    public var id: Int = 0
    public var name: String = ""
    
    public init?(dict: [String : Any]?) {
        guard let dict = dict else { return nil }
        self.id = dict["id"] as? Int ?? 0
        self.name = dict["name"] as? String ?? ""
    }
    
    public func dictionary() -> [String : Any]? {
        nil
    }
}

public struct ListGenres: NullableMap {
    public var genres: [MovieGenre] = []
    
    public init?(dict: [String : Any]?) {
        guard let dict = dict else { return nil }
        
        if let genres = dict["genres"] as? [[String:Any]] {
            self.genres = genres.map({MovieGenre(dict: $0)!})
        }
        
    }
    
    public func dictionary() -> [String : Any]? {
        nil
    }
}

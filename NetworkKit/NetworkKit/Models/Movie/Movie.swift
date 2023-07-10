//
//  Movie.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 01/07/23.
//

import Foundation


public struct Movie: NullableMap {
    
    public var genreIds: [Int] = []
    public var id: Int = 0
    public var originalLanguage: String = ""
    public var originalTitle: String = ""
    public var overview: String = ""
    public var popularity: Double
    public var posterPath: String = ""
    public var releaseDate: String = ""
    public var title: String = ""
    public var voteAverage: Double = 0
    public var voteCount: Int = 0
    public var videos: ListMovie?
    
    public init?(dict: [String: Any]?) {
        guard let dict = dict else { return nil }
        self.genreIds = dict["genre_ids"] as? [Int] ?? []
        self.id = dict["id"] as? Int ?? 0
        self.originalLanguage = dict["original_language"] as? String ?? ""
        self.originalTitle = dict["original_title"] as? String ?? ""
        self.overview = dict["overview"] as? String ?? ""
        self.popularity = dict["popularity"] as? Double ?? 0
        self.posterPath = dict["poster_path"] as? String ?? ""
        self.releaseDate = dict["release_date"] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.voteAverage = dict["vote_average"] as? Double ?? 0
        self.voteCount = dict["vote_count"] as? Int ?? 0
        
        if let videos = dict["videos"] as? [String:Any] {
            self.videos = ListMovie(dict: videos)
        }
    
        
    }
    
    public func dictionary() -> [String : Any]? {
        nil
    }
    
}

public struct ListMovie: NullableMap {
    public var list: [MovieVideo] = []
    
    public init?(dict: [String : Any]?) {
        guard let dict = dict else { return nil }
        if let result = dict["results"] as? [[String:Any]] {
            self.list = result.map({MovieVideo(dict: $0)!})
        }
        
    }
    
    public func dictionary() -> [String : Any]? {
        nil
    }
}

public struct MovieVideo: NullableMap {
    public var name: String = ""
    public var key: String = ""
    public var type: String = ""
    
    
    public init?(dict: [String : Any]?) {
        guard let dict = dict else { return nil }
        self.name = dict["name"] as? String ?? ""
        self.key = dict["key"] as? String ?? ""
        self.type = dict["trailer"] as? String ?? ""
    }
    
    public func dictionary() -> [String : Any]? {
        nil
    }
    
    
}

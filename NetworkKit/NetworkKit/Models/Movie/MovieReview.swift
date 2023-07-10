//
//  MovieReview.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 03/07/23.
//

import Foundation


public class MovieReview: NullableMap {
    
    public var author: String?
    public var content: String?
    public var name: String?
    
    public required init?(dict: [String : Any]?) {
        self.author = dict?["author"] as? String
        self.content = dict?["content"] as? String
    }
    
    public func dictionary() -> [String : Any]? {
        return nil
    }
    
}

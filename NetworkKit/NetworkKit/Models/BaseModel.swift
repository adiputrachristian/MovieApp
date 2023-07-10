//
//  BaseModel.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 28/02/23.
//

import Foundation
public protocol NullableMap {
    init? (dict: [String: Any]?)
    func dictionary() -> [String: Any]?
}

public struct BaseAuthModel: NullableMap {
    public var token: String?
    
    public init?(dict: [String : Any]?) {
        guard let dict = dict else {return nil}
        
        self.token = dict["token"] as? String

    }
    
    public func dictionary() -> [String : Any]? {
        var dict = [String: Any]()
        dict["token"] = token
        return dict
    }
}

public struct BaseListPokeCardModel<T>: NullableMap where T: NullableMap {
    public var data: [T]?
    
    /// Use this init for **list** type of backend response
    /// - Parameters:
    ///   - dict: the dictionary
    public init?(dict: [String: Any]?) {
        guard let dict = dict else {return nil}
        
        data = nil
        if let data = dict["data"] as? [[String: Any]] {
            self.data = data.compactMap({T(dict: $0)})
        }
        
    }
    public func dictionary() -> [String: Any]? {
        var dict = [String: Any]()
        dict["data"] = data?.compactMap({$0.dictionary()})
        return dict
    }
}

public struct BaseResultModel<T>: NullableMap where T: NullableMap {
    public var result: T?
    
    /// Use this init for **list** type of backend response
    /// - Parameters:
    ///   - dict: the dictionary
    public init?(dict: [String: Any]?) {
        guard let dict = dict else {return nil}
        
        result = nil
        self.result = dict["results"] as? T
        
    }
    public func dictionary() -> [String: Any]? {
        var dict = [String: Any]()
        dict["results"] = result
        return dict
    }
}


public struct BaseListModel<T>: NullableMap where T: NullableMap {
    public var result: [T]?
    public var totalPages: Int?
    
    /// Use this init for **list** type of backend response
    /// - Parameters:
    ///   - dict: the dictionary
    public init?(dict: [String: Any]?) {
        guard let dict = dict else {return nil}
        
        result = nil
        if let data = dict["results"] as? [[String: Any]] {
            self.result = data.compactMap({T(dict: $0)})
        }
        
        self.totalPages = dict["total_pages"] as? Int ?? 0
        
    }
    public func dictionary() -> [String: Any]? {
        var dict = [String: Any]()
        dict["results"] = result?.compactMap({$0.dictionary()})
        return dict
    }
}

public struct BaseListUser<T>: NullableMap where T: NullableMap {
    public var data: [T]?
    
    /// Use this init for **list** type of backend response
    /// - Parameters:
    ///   - dict: the dictionary
    public init?(dict: [String: Any]?) {
        guard let dict = dict else {return nil}
        
        data = nil
        if let data = dict["data"] as? [[String: Any]] {
            self.data = data.compactMap({T(dict: $0)})
        }
        
    }
    public func dictionary() -> [String: Any]? {
        var dict = [String: Any]()
        dict["data"] = data?.compactMap({$0.dictionary()})
        return dict
    }
}

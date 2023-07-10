//
//  MyPokedex.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 28/02/23.
//

import Foundation
import Moya

public enum PokeCardProvider {
    case getAllPokemonCard(page: Int)
    case searchPokemonCard(name: String)
    case getRecCard(page: Int, subtype: String, type: String)
}

extension PokeCardProvider: TargetType {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://api.pokemontcg.io/v2")!
        }
    }
    
    public var path: String {
        switch self {
        default:
            return "/cards"
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
        case .searchPokemonCard(let name):
            return .requestParameters(
                parameters: [
                    "q": "name:\(name)"
                ],
                encoding: URLEncoding.default
            )
        case .getAllPokemonCard(let page):
            return .requestParameters(
                parameters: [
                    "page": page,
                ],
                encoding: URLEncoding.default
            )
        case .getRecCard(let page, let subtype, let type):
            return .requestParameters(
                parameters: [
                    "page": page,
                    "q": "subtypes:\(subtype) -types:\(type)",
                    "pageSize": 3
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
}


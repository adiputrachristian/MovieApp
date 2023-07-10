//
//  PokedexProvider.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 05/03/23.
//

import Foundation
import Moya

public enum PokedexProvider {
    case getPokemonList(offSet: Int)
    case getPokemonDetail(pokemonId: Int)
}

extension PokedexProvider: TargetType {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://pokeapi.co/api/v2")!
        }
    }
    
    public var path: String {
        switch self {
        case .getPokemonDetail(let id):
            return "/pokemon/\(id)"
        case .getPokemonList(_):
            return "/pokemon"
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
        case .getPokemonList(let offSet):
            return .requestParameters(
                parameters: [
                    "limit": 20,
                    "offset": offSet
                ],
                encoding: URLEncoding.default
            )
        case .getPokemonDetail(_):
            return .requestPlain
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


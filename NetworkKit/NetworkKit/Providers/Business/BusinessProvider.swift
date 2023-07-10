//
//  BusinessProvider.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 17/05/23.
//

import Foundation
import Moya

public enum BusinessProvider {
    case getListBusiness(param: String, offset: Int, price: String)
    case getDetailBusiness(id: String)
    case getListReviews(id: String)
}

extension BusinessProvider: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.yelp.com/v3/businesses")!
    }
    
    public var path: String {
        switch self {
        case .getListBusiness(_):
            return "/search"
        case .getDetailBusiness(let id):
            return "/\(id)"
        case .getListReviews(id: let id):
            return "/\(id)/reviews"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Moya.Task {
        switch self {
        case .getListBusiness(let name, let offset, let price):
            if price == "" {
                return .requestParameters(
                    parameters: [
                        "offset" : offset,
                        "location" : name,
                        "sort_by" : "best_match",
                        "limit" : 20
                    ],
                    encoding: URLEncoding.default)
            }
            return .requestParameters(
                parameters: [
                    "price" : price,
                    "offset" : offset,
                    "location" : name,
                    "sort_by" : "best_match",
                    "limit" : 20
                ],
                encoding: URLEncoding.default)
        case .getDetailBusiness(_):
            return .requestPlain
        case .getListReviews(_):
            return .requestParameters(
                parameters: [
                    "sort_by" : "yelp_sort",
                    "limit" : 20
                ],
                encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return [
                "accept": "application/json",
                "Authorization": "Bearer Ubf1-f0uqsJUnssqPMGo-tiFeZTT85oFmKfznlPmjDtX8s83jYMoAb-ApuD63wgq6LDZNsUXG6gurZIVYaj2jzxJmmLdCdXbDqIHU_b6KiCEVi8v-YB0OSsW6MWaY3Yx"
            ]
        }
    }
    
    
}

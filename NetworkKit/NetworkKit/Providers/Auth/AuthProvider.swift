//
//  AuthProvider.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 08/04/23.
//

import Foundation
import Moya

public enum AuthProvider {
    case login(email: String, pass: String)
    case getUsers(page: Int)
}

extension AuthProvider: TargetType {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://reqres.in/")!
        }
    }
    
    public var path: String {
        switch self {
        case .login:
            return "api/login"
        case .getUsers:
            return "api/users"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .getUsers(let page):
            return .requestParameters(
                parameters: [
                    "page": page
                ],
                encoding: URLEncoding.default
            )

        case .login(let email, let pass):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": pass
                ],
                encoding: JSONEncoding.default
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



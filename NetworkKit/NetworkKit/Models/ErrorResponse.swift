//
//  ErrorResponse.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 28/02/23.
//

import Foundation

enum CommonError: Error {
    case mappingError
    case badRequest
    case requestFailed
    case forbidden
    case notFound
    
    var message: String {
        switch self {
        case .mappingError:
            return "No data or errors successfully mapped!"
        case .badRequest:
            return "Bad Request"
        case .requestFailed:
            return "Request Failed"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        }
    }
}

class ErrorModel: Error {
    var errorMessage: String = "Error"
    var apiCode: Int
    
    init?(object: Any, httpCode: Int? = nil) {
        guard let obj = object as? [String: Any],
              let meta = obj["error"] as? [String: Any]
        else {
            return nil
        }
        if let apiCode = meta["code"] as? Int {
            self.apiCode = apiCode
        } else {
            self.apiCode = 0
        }
        
        if let errorMessage = meta["message"] as? String {
            self.errorMessage = errorMessage
        }
        
        if let errorMessage = meta["description"] as? String {
            self.errorMessage = errorMessage
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

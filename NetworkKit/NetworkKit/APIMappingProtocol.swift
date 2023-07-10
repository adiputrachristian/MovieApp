//
//  APIMappingProtocol.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 28/02/23.
//

import Moya

protocol APIMappingProtocol {
    
}

extension APIMappingProtocol {
    func handleLoginResult(_ result: Result<Moya.Response, MoyaError>,
                                           onSuccess: ((String) -> Void)?,
                                           onFailure: ((Error) -> Void)? ) {
        switch result {
        case .success(let response):
            self.mapResponseUser(response, onSuccess: onSuccess, onFailure: onFailure)
        case .failure(let error):
            onFailure?(error)
        }
    }
    
    func handleResultLisCard<T: NullableMap>(_ result: Result<Moya.Response, MoyaError>,
                                             typeResponse: T.Type,
                                             onSuccess: ((BaseListPokeCardModel<T>) -> Void)?,
                                             onFailure: ((Error) -> Void)? ) {
        switch result {
        case .success(let response):
            self.mapResponse(response, type: typeResponse, onSuccess: onSuccess, onFailure: onFailure)
        case .failure(let error):
            onFailure?(error)
        }
    }
        
    func handleResultList<T: NullableMap>(_ result: Result<Moya.Response, MoyaError>,
                                                typeResponse: T.Type,
                                                onSuccess: ((BaseListModel<T>) -> Void)?,
                                                onFailure: ((Error) -> Void)? ) {
        switch result {
        case .success(let response):
            self.mapResponseList(response, type: typeResponse, onSuccess: onSuccess, onFailure: onFailure)
        case .failure(let error):
            onFailure?(error)
        }
    }
    
    func handleResult<T: NullableMap>(_ result: Result<Moya.Response, MoyaError>,
                                                typeResponse: T.Type,
                                                onSuccess: ((BaseResultModel<T>) -> Void)?,
                                                onFailure: ((Error) -> Void)? ) {
        switch result {
        case .success(let response):
            self.mapResponseResult(response, type: typeResponse, onSuccess: onSuccess, onFailure: onFailure)
        case .failure(let error):
            onFailure?(error)
        }
    }
    
    func handlePlainResult<T: NullableMap>(_ result: Result<Moya.Response, MoyaError>,
                                                typeResponse: T.Type,
                                                onSuccess: ((T) -> Void)?,
                                                onFailure: ((Error) -> Void)? ) {
        switch result {
        case .success(let response):
            self.mapPlainResponse(response, type: typeResponse, onSuccess: onSuccess, onFailure: onFailure)
        case .failure(let error):
            onFailure?(error)
        }
    }

    private func mapResponseUser(_ response: Moya.Response,
                                             onSuccess: ((String) -> Void)?,
                                             onFailure: ((Error) -> Void)? ) {
        DispatchQueue(label: "map_queue").async {
            do {
                let obj = try response.mapJSON()
                if let obj = obj as? [String: Any], let error = ErrorModel(object: obj, httpCode: response.statusCode) {
                    DispatchQueue.main.async { onFailure?(error) }
                } else {
                    guard let obj = obj as? [String: Any]
                    else {
                        DispatchQueue.main.async { onFailure?(CommonError.mappingError) }
                        return
                    }
                    
                    
                    if (obj["token"] != nil) {
                        DispatchQueue.main.async { onSuccess?(obj["token"] as! String) }
                    }
                }
                
            } catch {
                DispatchQueue.main.async { onFailure?(error) }
            }
        }
    }

    
    private func mapResponse<T: NullableMap>(_ response: Moya.Response,
                                             type: T.Type,
                                             onSuccess: ((BaseListPokeCardModel<T>) -> Void)?,
                                             onFailure: ((Error) -> Void)? ) {
        DispatchQueue(label: "map_queue").async {
            do {
                let obj = try response.mapJSON()
                if let obj = obj as? [String: Any], let error = ErrorModel(object: obj, httpCode: response.statusCode) {
                    DispatchQueue.main.async { onFailure?(error) }
                } else {
                    guard let obj = obj as? [String: Any],
                          let response = BaseListPokeCardModel<T>(dict: obj)
                    else {
                        DispatchQueue.main.async { onFailure?(CommonError.mappingError) }
                        return
                    }
                    
                    DispatchQueue.main.async { onSuccess?(response) }
                }
                
            } catch {
                DispatchQueue.main.async { onFailure?(error) }
            }
        }
    }
    
    private func mapResponseList<T: NullableMap>(_ response: Moya.Response,
                                                    type: T.Type,
                                                    onSuccess: ((BaseListModel<T>) -> Void)?,
                                                    onFailure: ((Error) -> Void)? ) {
        DispatchQueue(label: "map_").async {
            do {
                let obj = try response.mapJSON()
                if let obj = obj as? [String: Any], let error = ErrorModel(object: obj, httpCode: response.statusCode) {
                    DispatchQueue.main.async { onFailure?(error) }
                } else {
                    guard let obj = obj as? [String: Any],
                          let response = BaseListModel<T>(dict: obj)
                    else {
                        DispatchQueue.main.async { onFailure?(CommonError.mappingError) }
                        return
                    }
                    
                    DispatchQueue.main.async { onSuccess?(response) }
                }
                
            } catch {
                DispatchQueue.main.async { onFailure?(error) }
            }
        }
    }
    
    private func mapResponseResult<T: NullableMap>(_ response: Moya.Response,
                                                    type: T.Type,
                                                    onSuccess: ((BaseResultModel<T>) -> Void)?,
                                                    onFailure: ((Error) -> Void)? ) {
        DispatchQueue(label: "map_").async {
            do {
                let obj = try response.mapJSON()
                if let obj = obj as? [String: Any], let error = ErrorModel(object: obj, httpCode: response.statusCode) {
                    DispatchQueue.main.async { onFailure?(error) }
                } else {
                    guard let obj = obj as? [String: Any],
                          let response = BaseResultModel<T>(dict: obj)
                    else {
                        DispatchQueue.main.async { onFailure?(CommonError.mappingError) }
                        return
                    }
                    
                    DispatchQueue.main.async { onSuccess?(response) }
                }
                
            } catch {
                DispatchQueue.main.async { onFailure?(error) }
            }
        }
    }
    
    private func mapPlainResponse<T: NullableMap>(_ response: Moya.Response,
                                                    type: T.Type,
                                                    onSuccess: ((T) -> Void)?,
                                                    onFailure: ((Error) -> Void)? ) {
        DispatchQueue(label: "map_").async {
            do {
                let obj = try response.mapJSON()
                if let obj = obj as? [String: Any], let error = ErrorModel(object: obj, httpCode: response.statusCode) {
                    DispatchQueue.main.async { onFailure?(error) }
                } else {
                    guard let obj = obj as? [String: Any],
                          let response = T(dict: obj)
                    else {
                        DispatchQueue.main.async { onFailure?(CommonError.mappingError) }
                        return
                    }
                    
                    DispatchQueue.main.async { onSuccess?(response) }
                }
                
            } catch {
                DispatchQueue.main.async { onFailure?(error) }
            }
        }
    }

    
}

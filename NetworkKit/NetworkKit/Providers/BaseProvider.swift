//
//  BaseProvider.swift
//  NetworkKit
//
//  Created by Christian Adiputra on 28/02/23.
//

import Moya

public class BaseProvider<T: TargetType>: MoyaProvider<T> {
    public final class func endpointClosure (target: T) -> Endpoint {
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        return defaultEndpoint
    }
    
    public override init(endpointClosure: @escaping MoyaProvider<T>.EndpointClosure = BaseProvider.endpointClosure,
                         //        modified
                         requestClosure: @escaping MoyaProvider<T>.RequestClosure = MoyaProvider<T>.defaultRequestMapping,
                         stubClosure: @escaping MoyaProvider<T>.StubClosure = MoyaProvider.neverStub,
                         callbackQueue: DispatchQueue? = nil,
                         session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
                         plugins: [PluginType] = [],
                         trackInflights: Bool = false) {
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure,
                   callbackQueue: callbackQueue, session: session, plugins: plugins, trackInflights: trackInflights)
    }
}

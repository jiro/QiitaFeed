//
//  QiitaAPI.swift
//  QiitaFeed
//
//  Created by Jiro Nagashima on 2/27/15.
//  Copyright (c) 2015 Jiro Nagashima. All rights reserved.
//

import Foundation
import Moya

public enum QiitaAPI {
    case TagItems(String)
}

extension QiitaAPI : MoyaPath {
    public var path: String {
        switch self {
        case .TagItems(let tagID):
            return "/api/v2/tags/\(tagID)/items"
        }
    }
}

extension QiitaAPI : MoyaTarget {
    public var baseURL: NSURL { return NSURL(string: "https://qiita.com")! }
    public var sampleData: NSData {
        switch self {
        case .TagItems:
            return NSData()
        }
    }
}

// MARK: - Provider setup

let endpointsClosure = { (target: QiitaAPI, method: Moya.Method, parameters: [String: AnyObject]) -> Endpoint<QiitaAPI> in
    return Endpoint<QiitaAPI>(URL: url(target), sampleResponse: .Success(200, target.sampleData), method: method, parameters: parameters)
}

let QiitaProvider = MoyaProvider(endpointsClosure: endpointsClosure)

// MARK: - Provider support

public func url(route: MoyaTarget) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString!
}


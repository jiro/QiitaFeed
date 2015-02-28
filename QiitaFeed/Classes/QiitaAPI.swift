//
//  QiitaAPI.swift
//  QiitaFeed
//
//  Created by Jiro Nagashima on 2/27/15.
//  Copyright (c) 2015 Jiro Nagashima. All rights reserved.
//

import Foundation
import Moya

enum QiitaAPI {
    case Items
    case TagItems(String)
}

extension QiitaAPI : MoyaPath {
    var path: String {
        switch self {
        case .Items:
            return "/api/v2/items"
        case .TagItems(let tagID):
            return "/api/v2/tags/\(tagID)/items"
        }
    }
}

extension QiitaAPI : MoyaTarget {
    var baseURL: NSURL { return NSURL(string: "https://qiita.com")! }
    var sampleData: NSData {
        switch self {
        case .Items, .TagItems:
            return stubbedResponse("Items")
        }
    }
}

// MARK: - Provider setup

struct QiitaProvider {
    static let endpointsClosure = { (target: QiitaAPI, method: Moya.Method, parameters: [String: AnyObject]) -> Endpoint<QiitaAPI> in
        return Endpoint<QiitaAPI>(URL: url(target), sampleResponse: .Success(200, target.sampleData), method: method, parameters: parameters)
    }

    static func DefaultProvider() -> ReactiveMoyaProvider<QiitaAPI> {
        return ReactiveMoyaProvider(endpointsClosure: endpointsClosure)
    }

    static func StubbingProvider() -> ReactiveMoyaProvider<QiitaAPI> {
        return ReactiveMoyaProvider(endpointsClosure: endpointsClosure, stubResponses: true)
    }

    private struct SharedProvider {
        static var instance = QiitaProvider.DefaultProvider()
    }

    static var sharedProvider: ReactiveMoyaProvider<QiitaAPI> {
        get {
            return SharedProvider.instance
        }

        set (newSharedProvider) {
            SharedProvider.instance = newSharedProvider
        }
    }
}

// MARK: - Provider support

private func stubbedResponse(filename: String) -> NSData! {
    @objc class TestClass { }

    let bundle = NSBundle(forClass: TestClass.self)
    let path = bundle.pathForResource(filename, ofType: "json")
    return NSData(contentsOfFile: path!)
}

private func url(route: MoyaTarget) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString!
}

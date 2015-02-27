//
//  Item.swift
//  QiitaFeed
//
//  Created by Jiro Nagashima on 2/27/15.
//  Copyright (c) 2015 Jiro Nagashima. All rights reserved.
//

import Foundation
import SwiftyJSON
import ReactiveCocoa
import Moya

class Item: NSObject {
    let title: String

    init(title: String) {
        self.title = title
    }

    private class func fromJSON(json: [String: AnyObject]) -> Item {
        let json = JSON(json)
        let title = json["title"].stringValue
        return Item(title: title)
    }

    class func tagItems(tagID: String) -> RACSignal {
        return QiitaProvider.request(.TagItems(tagID)).filterSuccessfulStatusCodes().mapJSON().mapToItems()
    }
}

extension RACSignal {
    private func mapToItems() -> RACSignal {
        return tryMap { (object, error) -> AnyObject! in
            if let dicts = object as? [[String: AnyObject]] {
                let items: [Item] =  dicts.map({ return Item.fromJSON($0) })
                return items
            }

            if error != nil {
                error.memory = NSError(domain: MoyaErrorDomain, code: MoyaErrorCode.Data.rawValue, userInfo: ["data": object])
            }

            return nil
        }
    }
}

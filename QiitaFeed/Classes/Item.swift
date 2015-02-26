//
//  Item.swift
//  QiitaFeed
//
//  Created by Jiro Nagashima on 2/27/15.
//  Copyright (c) 2015 Jiro Nagashima. All rights reserved.
//

import Foundation
import SwiftyJSON

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

    class func items(completion: ([Item]) -> ()) {
        QiitaProvider.request(.TagItems("swift")) { (data, status, response, error) in
            var items = [Item]()

            if let data = data {
                let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
                if let json = json as? [[String: AnyObject]] {
                    items = json.map({ return self.fromJSON($0) })
                }
            }
            completion(items)
        }
    }
}

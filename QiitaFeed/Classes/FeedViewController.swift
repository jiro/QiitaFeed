//
//  FeedViewController.swift
//  QiitaFeed
//
//  Created by Jiro Nagashima on 2/26/15.
//  Copyright (c) 2015 Jiro Nagashima. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController {
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        Item.items { (items) in
            self.items = items
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as UITableViewCell
        let item = items[indexPath.row]
        cell.textLabel!.text = item.title
        return cell
    }
}

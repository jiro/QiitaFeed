//
//  TableViewController.swift
//  QiitaFeed
//
//  Created by Nagashima Jiro on 2/28/15.
//  Copyright (c) 2015 Jiro Nagashima. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    // MARK: - Table view delegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier("ShowItems", sender: cell)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItems" {
            let cell = sender as UITableViewCell

            if tableView.indexPathForCell(cell)?.section == 1 {
                let tag = cell.textLabel?.text ?? ""
                (segue.destinationViewController as ItemsViewController).tag = tag
            }
        }
    }
}

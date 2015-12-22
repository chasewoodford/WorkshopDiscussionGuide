//
//  OptionsTableViewController.swift
//  WorkshopDiscussionGuide
//
//  Created by Chase Woodford on 11/16/15.
//  Copyright (c) 2015 Chase Woodford. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {

    var options = [Option]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var optionItem = Option(name: "Share", description: "This is the share option details page")
        options.append(optionItem)
        
        optionItem = Option(name: "About", description: "This is the about option details page")
        options.append(optionItem)
        
        optionItem = Option(name: "Help", description: "This is the help option details page")
        options.append(optionItem)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "dismiss")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath) as UITableViewCell
        
        let currentOption = options[indexPath.row]
        
        // Set cell label
        cell.textLabel?.text = currentOption.name
        
//        // Customizations for each cell
//        switch indexPath.row {
//            case 0:
//                // cell.imageView?.image =
//            case 1:
//                // cell.imageView?.image =
//            case 2:
//                // cell.imageView?.image =
//            default:
//        }
        
        return cell
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let secondScene = segue.destinationViewController as! OptionsTableDetailViewController
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedOption = options[indexPath.row]
            secondScene.optionItem = selectedOption
        }
    }
    
}

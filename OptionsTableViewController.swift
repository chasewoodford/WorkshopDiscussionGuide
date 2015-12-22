//
//  OptionsTableViewController.swift
//  WorkshopDiscussionGuide
//
//  Created by Chase Woodford on 11/16/15.
//  Copyright (c) 2015 Chase Woodford. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {
    
    let versionNumber = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    let year = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)!.component(NSCalendarUnit.Year, fromDate: NSDate())

    var options = [Option]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var optionItem = Option(
            name: "Share",
            description: "This should be replaced with options for saving and sharing notes. This may need a scene of its own."
        )
        options.append(optionItem)
        
        optionItem = Option(
            name: "About",
            description: "Verilogue's Workshop Discussion Guide app is a digital note-taking companion for live, on-site listening workshops.\n\rFor convenience, and to reduce the amount of printed materials needed to create an engaging dialogue experience for brand and agency teams, Verilogue makes available its digital Workshop Discussion Guide free of charge.\n\rAs with a printed Workshop Discussion Guide worksheet, this app allows users to record notes for each interaction explored during a Listening Workshop. Unlike a printed document, however, this app allows users to easily save and share digital copies of notes. Additionally, user notes are not limited in size by the available physical space of a piece of paper.\n\rVerilogue, Inc. © \(year)\nwww.verilogue.com\nVersion: \(versionNumber)"
        )
        options.append(optionItem)
        
        optionItem = Option(
            name: "Help",
            description: "This should be like a bulleted list of FAQs."
        )
        options.append(optionItem)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "dismiss")
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
        let optionDetailScene = segue.destinationViewController as! OptionsTableDetailViewController
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedOption = options[indexPath.row]
            optionDetailScene.optionItem = selectedOption
        }
    }
    
}

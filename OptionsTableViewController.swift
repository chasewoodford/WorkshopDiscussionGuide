//
//  OptionsTableViewController.swift
//  WorkshopDiscussionGuide
//  Copyright (c) 2015 Chase Woodford. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {

    var options = [Option]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var optionItem = Option (name: "About", description: "")
        options.append(optionItem)
        
        optionItem = Option (name: "Help", description: "")
        options.append(optionItem)
        
        optionItem = Option (name: "Share", description: "")
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
        
        cell.textLabel?.text = currentOption.name
        tableView.separatorStyle = .None
        
        // Customizations for each cell
        switch indexPath.row {
            case 0:
                cell.imageView?.image = UIImage(named: "about")
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case 1:
                cell.imageView?.image = UIImage(named: "help")
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case 2:
                cell.imageView?.image = UIImage(named: "share")
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.selectionStyle = UITableViewCellSelectionStyle.None
            default:
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.selectionStyle = UITableViewCellSelectionStyle.None
        }
        
        return cell
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Segues
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        let indexPath = self.tableView.indexPathForSelectedRow
        if indexPath!.row == 2 {
            let activityItem = "This is the text to share"
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
            self.presentViewController(activityVC, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let optionDetailScene = segue.destinationViewController as! OptionsTableDetailViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedOption = options[indexPath.row]
            optionDetailScene.optionItem = selectedOption
        }
    }
    
}

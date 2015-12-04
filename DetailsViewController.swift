//
//  DetailsViewController.swift
//  WorkshopDiscussionGuide
//
//  Created by Chase Woodford on 11/28/15.
//  Copyright © 2015 Chase Woodford. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var interactionID: UITextField!
    @IBOutlet weak var createdDatetimeLabel: UILabel!
    @IBOutlet weak var conversationDynamicsTextView: UITextView!
    @IBOutlet weak var keyTakeawaysTextView: UITextView!
    @IBOutlet weak var implicationsTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        print("Button pressed!")
    }
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        if let detail = self.detailItem {
            // Display existing note
            if let interactionID = self.interactionID {
                interactionID.text = detail.valueForKey("interactionID")!.description
            }
            
            if let createdDatetime = self.createdDatetimeLabel {
                let formatted = NoteManager.sharedInstance.formatDateToString(detail.valueForKey("createdDatetime") as! NSDate)
                createdDatetime.text = "Created on " + formatted
            }
            
            if let conversationDynamics = self.conversationDynamicsTextView {
                conversationDynamics.text = detail.valueForKey("conversationDynamics")!.description
            }
            
            if let keyTakeaways = self.keyTakeawaysTextView {
                keyTakeaways.text = detail.valueForKey("keyTakeaways")!.description
            }
            
            if let implications = self.implicationsTextView {
                implications.text = detail.valueForKey("implications")!.description
            }
            
        } else {
            // Display new note
            if let interactionID = self.interactionID {
                interactionID.text = ""
            }
            
            if let createdDatetime = self.createdDatetimeLabel {
                createdDatetimeLabel.text = "Created on " + NoteManager.sharedInstance.formatDateToString(NSDate())
            }
            
            if let conversationDynamics = self.conversationDynamicsTextView {
                conversationDynamicsTextView.text = ""
            }
            
            if let keyTakeaways = self.keyTakeawaysTextView {
                keyTakeawaysTextView.text = ""
            }
            
            if let implications = self.implicationsTextView {
                implicationsTextView.text = ""
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

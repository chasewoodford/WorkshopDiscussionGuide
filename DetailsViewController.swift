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
        if let _ = self.detailItem {
            self.updateNote()
        } else {
            self.saveNote()
        }
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func saveNote(){
        let interactionID:Int? = Int(self.interactionID.text!)
        let conversationDynamics = self.conversationDynamicsTextView.text
        let keyTakeaways = self.keyTakeawaysTextView.text
        let implications = self.implicationsTextView.text
        
        NoteManager.sharedInstance.insertNewObject(interactionID!, conversationDynamics: conversationDynamics, keyTakeaways: keyTakeaways, implications: implications)
    }
    
    func updateNote(){
        if let detail = self.detailItem {
            detail.setValue(self.interactionID!.text, forKey: "interactionID")
            detail.setValue(self.conversationDynamicsTextView!.text, forKey: "conversationDynamics")
            detail.setValue(self.keyTakeawaysTextView, forKey: "keyTakeaways")
            detail.setValue(self.implicationsTextView, forKey: "implications")
            
            do {
                try NoteManager.sharedInstance.managedObjectContext.save()
            } catch {
                abort()
            }
        }
    }
}

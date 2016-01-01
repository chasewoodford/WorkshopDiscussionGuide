//
//  DetailsViewController.swift
//  WorkshopDiscussionGuide
//  Copyright © 2015 Chase Woodford. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
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
        initializeTextFields()
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
                createdDatetime.text = "Note created on " + formatted
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
            if let _ = self.createdDatetimeLabel {
                createdDatetimeLabel.text = "Created on " + NoteManager.sharedInstance.formatDateToString(NSDate())
            }
        }
    }
    
    func saveNote(){
        let interactionID = self.interactionID.text
        let conversationDynamics = self.conversationDynamicsTextView.text
        let keyTakeaways = self.keyTakeawaysTextView.text
        let implications = self.implicationsTextView.text

        NoteManager.sharedInstance.insertNewObject(interactionID!, conversationDynamics: conversationDynamics, keyTakeaways: keyTakeaways, implications: implications)
        print("Save successful")
        // Dimiss view on save
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    func updateNote(){
        if let detail = self.detailItem {
            detail.setValue(self.interactionID.text, forKey: "interactionID")
            detail.setValue(self.conversationDynamicsTextView.text, forKey: "conversationDynamics")
            detail.setValue(self.keyTakeawaysTextView.text, forKey: "keyTakeaways")
            detail.setValue(self.implicationsTextView.text, forKey: "implications")
            
            do {
                try NoteManager.sharedInstance.managedObjectContext.save()
                print("Update successful")
                // Dismiss view on update
                self.dismissViewControllerAnimated(true, completion: {});
            } catch {
                // TODO: Add error handling
                abort()
            }
        }
    }
    
    // Clear keyboard on touch outside UI element
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view .endEditing(true)
    }
    
    // Set up keyboards
    func initializeTextFields() {
        interactionID.delegate = self
        interactionID.keyboardType = UIKeyboardType.NumberPad
        conversationDynamicsTextView.delegate = self
        conversationDynamicsTextView.keyboardType = UIKeyboardType.ASCIICapable
        keyTakeawaysTextView.delegate = self
        keyTakeawaysTextView.keyboardType = UIKeyboardType.ASCIICapable
        implicationsTextView.delegate = self
        implicationsTextView.keyboardType = UIKeyboardType.ASCIICapable
    }
    
    // Enable save button after editing Interaction ID
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.saveButton.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.saveButton.enabled = true
        
        // Validate changes against constraints
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        switch textField {
            // Allow only 6 digits
            case interactionID:
                return prospectiveText.containsOnlyCharactersIn("0123456789") &&
                    prospectiveText.characters.count <= 6
            
            // Do not put constraints on any other text field
            default:
                return true
        }
    }
    
    // Enable save button after editing text view input
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        self.saveButton.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.saveButton.enabled = true
        return true
    }
    
}

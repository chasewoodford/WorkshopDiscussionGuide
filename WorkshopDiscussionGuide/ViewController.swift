//
//  ViewController.swift
//  WorkshopDiscussionGuide
//
//  Created by Chase Woodford on 11/14/15.
//  Copyright (c) 2015 Chase Woodford. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    var detailViewController: DetailsViewController? = nil
    var resultsController = NoteManager.sharedInstance.fetchedResultsController
    
    @IBOutlet weak var textMainTitle: UITextField!
    @IBOutlet weak var textMainSubTitle: UITextField!
    @IBOutlet weak var addNewButton: UIButton!
    
    // On end of editing of Main Title
    @IBAction func changeTextMainTitle(sender: UITextField) {
        self.textMainTitle.resignFirstResponder()
    }
    
    // On end of editing of Main Sub Title
    @IBAction func changeTextMainSubTitle(sender: UITextField) {
        self.textMainSubTitle.resignFirstResponder()
    }
    
    // Clear keyboard on return key strike
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // TODO: Loop through each note object in memory
        let noteObjectBtn = UIButton(type: UIButtonType.System) as UIButton
        // TODO: Make positioning relative
        noteObjectBtn.frame = CGRectMake(195, 195, 152, 152)
        noteObjectBtn.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        // TODO: Make title dynamically set
        noteObjectBtn.setTitle("Interaction\n123456", forState: UIControlState.Normal)
        noteObjectBtn.titleLabel!.lineBreakMode = .ByWordWrapping
        noteObjectBtn.titleLabel!.textAlignment = .Center
        noteObjectBtn.addTarget(self, action: "noteObjectButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(noteObjectBtn)
    }
    
    func noteObjectButtonAction(sender: UIButton!) {
        // TODO: Segue to Details view
        print("Button tapped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


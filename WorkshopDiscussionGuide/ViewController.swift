//
//  ViewController.swift
//  WorkshopDiscussionGuide
//  Copyright (c) 2015 Chase Woodford. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    let year = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)!.component(NSCalendarUnit.Year, fromDate: NSDate())

    var resultsController = NoteManager.sharedInstance.fetchedResultsController
    
    @IBOutlet weak var textMainTitle: UITextField!
    @IBOutlet weak var textMainSubTitle: UITextField!
    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsController.delegate = self
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        // Show disclaimer immediately after launching app
        let myAlert = UIAlertView(title: "Disclaimer", message: "Verilogue, Inc. © \(year)\n\rThis app is in beta. Verilogue makes no guarantees on the performance of this app. Use at your own risk.", delegate: nil, cancelButtonTitle: "Agree")
        myAlert .show()
        
        // Set gesture recognizer for collection view cell deletion
        let lpgr = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = 0.3
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.collectionView.addGestureRecognizer(lpgr)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.collectionView.reloadData()
    }
    
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
    
    // MARK: Collection View
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let notesCount = resultsController.sections![section]
        return notesCount.numberOfObjects
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        let noteBackgroundImage = UIImage(named: "noteBackground")
        
        cell.imageView?.image = noteBackgroundImage
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: CollectionViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = resultsController.objectAtIndexPath(indexPath)
        let interactionID = object.valueForKey("interactionID")!.description
        cell.noteTitle!.text = "Interaction\n" + interactionID
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showNoteDetails", sender: self)
    }
    
    // MARK: Long gesture handling
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.Began {
            return
        }
        
        let p = gestureReconizer.locationInView(self.collectionView)
        let indexPath = self.collectionView.indexPathForItemAtPoint(p)
        
        if let index = indexPath {
            var cell = self.collectionView.cellForItemAtIndexPath(index)
            let object = resultsController.objectAtIndexPath(indexPath!)
            let interactionID = object.valueForKey("interactionID")!.description
            let alertController = UIAlertController (
                title: "Would you like to delete note for Interaction \(interactionID)?",
                message: "Click Delete to delete your note.\nClick Cancel to keep your note.",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            
            alertController.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { (action: UIAlertAction!) in print("Handle Ok logic for \(index.row) here") }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in print("Handle Cancel logic for \(index.row) here") }))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            print("Could not find index path")
        }
    }
    
    // MARK: Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNoteDetails" {
            if let indexPath = collectionView?.indexPathsForSelectedItems()?.first {
                let object = resultsController.objectAtIndexPath(indexPath)
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailsViewController
                controller.detailItem = object
            }
        }
    }
    
}


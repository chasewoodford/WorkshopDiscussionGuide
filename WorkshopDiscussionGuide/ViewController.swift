//
//  ViewController.swift
//  WorkshopDiscussionGuide
//
//  Created by Chase Woodford on 11/14/15.
//  Copyright (c) 2015 Chase Woodford. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let year = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)!.component(NSCalendarUnit.Year, fromDate: NSDate())
    // TODO: Make the notes load from core data
    let notes = ["Interaction\n111111", "Interaction\n222222", "Interaction\n333333", "Interaction\n444444", "Interaction\n555555", "Interaction\n666666"]
    let noteBackgroundImage = UIImage(named: "noteBackground")
    
//    var detailViewController: DetailsViewController? = nil
    var resultsController = NoteManager.sharedInstance.fetchedResultsController
    
    @IBOutlet weak var textMainTitle: UITextField!
    @IBOutlet weak var textMainSubTitle: UITextField!
    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show disclaimer immediately after launching app
        let myAlert = UIAlertView(title: "Disclaimer", message: "Verilogue, Inc. © \(year)\n\rThis app is in beta. Verilogue makes no guarantees on the performance of this app. Use at your own risk.", delegate: nil, cancelButtonTitle: "Agree")
        myAlert .show()
        resultsController.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return self.notes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.imageView?.image = self.noteBackgroundImage
        cell.noteTitle?.text = self.notes[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showNoteDetails", sender: self)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNoteDetails" {
            let indexPath = collectionView?.indexPathsForSelectedItems()?.first
            print(indexPath!.row)
        }
    }
    
}


//
//  ViewController.swift
//  WorkshopDiscussionGuide
//
//  Created by Chase Woodford on 11/14/15.
//  Copyright (c) 2015 Chase Woodford. All rights reserved.
//

import UIKit

var objects:[String] = [String]()

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textMainTitle: UITextField!
    @IBOutlet weak var textMainSubTitle: UITextField!
    @IBOutlet weak var addNew: UIButton!
    
    // On end of editing of Main Title
    @IBAction func changeTextMainTitle(sender: UITextField) {
        self.textMainTitle.resignFirstResponder()
    }
    
    // On end of editing of Main Sub Title
    @IBAction func changeTextMainSubTitle(sender: UITextField) {
        self.textMainSubTitle.resignFirstResponder()
    }
    
    @IBAction func addNew(sender: AnyObject) {
        
    }
    
    // Clear keyboard on return key strike
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if objects.count > 0 {
            // Show the objects
            // Show the Add New button last
        } else {
            // Show the Add New Button
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func save() {
//        NSUserDefaults.standardUserDefaults().setObject(objects, forKey: kNotes)
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
    
//    func load() {
//        if let loadedData = NSUserDefaults.standardUserDefaults().arrayForKey(kNotes) as? [String] {
//            objects = loadedData
//        }
//    }

}


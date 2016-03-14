//
//  OptionsTableDetailViewController.swift
//  WorkshopDiscussionGuide
//  Copyright © 2015 Chase Woodford. All rights reserved.
//

import UIKit

class OptionsTableDetailViewController: UIViewController {
    
    var optionItem: Option?
    
    @IBOutlet weak var optionItemDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = optionItem!.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "dismiss")
        
        if optionItem!.name == "About" {
            
            let versionNumber = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
            let year = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)!.component(NSCalendarUnit.Year, fromDate: NSDate())
            
            let description = "Verilogue's Workshop Discussion Guide app is a digital note-taking companion for live, on-site listening workshops.\n\rFor convenience, and to reduce the amount of printed materials needed to create an engaging dialogue experience for brand and agency teams, Verilogue makes available its digital Workshop Discussion Guide free of charge.\n\rAs with a printed Workshop Discussion Guide worksheet, this app allows users to record notes for each interaction explored during a Listening Workshop. Unlike a printed document, however, this app allows users to easily save and share digital copies of notes. Additionally, user notes are not limited in size by the available physical space of a piece of paper.\n\rVerilogue, Inc. © \(year)\nwww.verilogue.com\nVersion: \(versionNumber)"
            
            optionItemDescription.text = description
            
        } else if optionItem!.name == "Help" {

            let faqs: [Int: [String: String]] = [
                1: [
                    "question"  :   "How do I use this app?",
                    "answer"    :   "Close your eyes and move your fingers."
                ],
                2: [
                    "question"  :   "How much does this app cost?",
                    "answer"    :   "Absolutely nothing!"
                ],
                3: [
                    "question"  :   "What do I do with this app?",
                    "answer"    :   "Take notes."
                ]
            ]

            print("The dictionary contains \(faqs.count) sets.\n")
            
            var text: String = ""
            
            for set in faqs.values {
                let question = "\(set["question"]!)\n"
                let answer = "\(set["answer"]!)\n\n"
                text += question + answer
            }
            
            let faqText: NSString = text
            let boldString: NSMutableAttributedString = NSMutableAttributedString(string: faqText as String)
            
            boldString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(15)], range: NSRange(location: 0, length: 28))
            boldString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(15)], range: NSRange(location: 40, length: 29))
            boldString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(15)], range: NSRange(location: 90, length: 24))
            
            optionItemDescription.attributedText = boldString
            
        } else {
            optionItemDescription.text = optionItem!.description
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

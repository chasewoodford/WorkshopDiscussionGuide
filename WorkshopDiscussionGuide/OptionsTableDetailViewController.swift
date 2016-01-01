//
//  OptionsTableDetailViewController.swift
//  WorkshopDiscussionGuide
//  Copyright © 2015 Chase Woodford. All rights reserved.
//

import UIKit

class OptionsTableDetailViewController: UIViewController {
    
    var optionItem: Option?
    
    @IBOutlet weak var optionItemDescription: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        if optionItem!.name == "Share" {
            let activityItem = "This is the text to share"
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionItemDescription.text = optionItem!.description
        self.title = optionItem!.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "dismiss")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

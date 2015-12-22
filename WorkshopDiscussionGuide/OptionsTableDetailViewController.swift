//
//  OptionsTableDetailViewController.swift
//  WorkshopDiscussionGuide
//
//  Created by Chase Woodford on 12/21/15.
//  Copyright © 2015 Chase Woodford. All rights reserved.
//

import UIKit

class OptionsTableDetailViewController: UIViewController {
    
    var optionItem: Option?
    
    @IBOutlet weak var optionItemDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionItemDescription.text = optionItem!.description
        self.title = optionItem!.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "dismiss")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

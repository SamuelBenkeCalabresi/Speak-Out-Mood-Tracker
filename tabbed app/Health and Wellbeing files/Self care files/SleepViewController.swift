//
//  SleepViewController.swift
//  Speak Out!
//
//  Created by admin on 03/07/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class SleepViewController: UIViewController {

    @IBOutlet weak var sleepText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        sleepText.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }

}

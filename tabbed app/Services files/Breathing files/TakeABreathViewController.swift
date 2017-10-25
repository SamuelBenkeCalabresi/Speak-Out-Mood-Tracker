//
//  TakeABreathViewController.swift
//  Speak Out!
//
//  Created by admin on 25/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class TakeABreathViewController: UIViewController {

    @IBOutlet weak var takeABreath: UITextView!
    @IBOutlet weak var gifBreathingExercise: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gifBreathingExercise.loadGif(name: "breathing")
    }
    
    override func viewDidLayoutSubviews() {
        takeABreath.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
}

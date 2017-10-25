//
//  HealthDataViewController.swift
//  Speak Out!
//  Created by admin on 24/05/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.

import UIKit

class HealthDataViewController: UIViewController {
    @IBOutlet weak var eatingProblemsButton: UIButton!
    @IBOutlet weak var anxietyButton: UIButton!
    @IBOutlet weak var angerIssuesButton: UIButton!
    @IBOutlet weak var selfHarmingButton: UIButton!
    @IBOutlet weak var depressionButton: UIButton!
    @IBOutlet weak var suicidalFeelings: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtons()
    }
    
    func setButtons() {        
        // Adjust size of each button programmatically
        adjustFontSizeOf(button: eatingProblemsButton)
        adjustFontSizeOf(button: anxietyButton)
        adjustFontSizeOf(button: angerIssuesButton)
        adjustFontSizeOf(button: suicidalFeelings)
        adjustFontSizeOf(button: selfHarmingButton)
        adjustFontSizeOf(button: depressionButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func adjustFontSizeOf(button mybutton: UIButton) {
        mybutton.titleLabel?.minimumScaleFactor = 0.2
        mybutton.titleLabel?.numberOfLines = 1
        mybutton.titleLabel?.adjustsFontSizeToFitWidth = true
    }

}

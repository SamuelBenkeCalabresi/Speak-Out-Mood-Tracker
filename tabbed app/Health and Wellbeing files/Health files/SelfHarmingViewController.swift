//
//  SelfHarmingViewController.swift
//  Speak Out!
//
//  Created by admin on 06/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class SelfHarmingViewController: StackAnimatorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func changeDataModels() {
        
        let descriptionStr = "Self-harm is when a person hurts themselves intentionally. They may do it because something else feels wrong, or because they have overwhelming feelings and they don’t t know how to cope with them.  Self Harm  may seem like a way of coping with those feelings in the short term.\r"
        
        var symptoms = "In the short term, if someone is self-harming they may be:\r\r"
        symptoms +=  "• Cutting.\r\r"
        symptoms += "• Burning.\r\r"
        symptoms += "• Taking an overdose of tablets.\r\r"
        symptoms += "• Swallowing harmful substances or objects.\r\r"
        symptoms += "• Taking drugs.\r\r"
        symptoms += "• Drinking excessive amounts of alcohol.\r\r"
        
        let howToHandleItStr = "Learning to tolerate and cope with confusing and changing moods is an important part of growing and self harm can get in the way of this important process and become a negative habit. It is important that anyone who self harms visits their GP, tells a teacher or a trusted adult in the school or the community how you are feeling. Talking therapies will help you find other ways of coping."
        
        dataModel = ["What is", "Symptoms", "How to handle it"]
        
        dataContent = [descriptionStr, symptoms, howToHandleItStr,]
        
        dataURLS = ["https://youngminds.org.uk/find-help/feelings-and-symptoms/self-harm/",
                    "http://www.nhs.uk/conditions/Self-injury/Pages/Introduction.aspx",
                    "https://youngminds.org.uk/find-help/feelings-and-symptoms/self-harm/#what-to-do-about-self-harm?",]
    }

}

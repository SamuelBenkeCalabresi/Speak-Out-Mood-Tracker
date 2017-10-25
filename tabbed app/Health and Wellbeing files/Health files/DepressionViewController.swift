//
//  DepressionViewController.swift
//  Speak Out!
//
//  Created by admin on 06/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class DepressionViewController: StackAnimatorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Override the changeDataModels to change it the viewDidLoad in the
    // StackAnimatorViewController superclass
    override func changeDataModels() {
        
        let descriptionStr = "Depression is defined as a mood disorder where you feel down all the time.\r"
        
        var symptoms =  "• Fatigue and decreased energy levels.\r\r"
        symptoms += "• Disturbed sleep routines. For example, finding it difficult to fall asleep at night or waking up very early in the morning.\r\r"
        symptoms += "• Lack of concentration.\r\r"
        symptoms += "• Overthinking.\r\r"
        symptoms += "• Feeling suicidal.\r\r"
        symptoms += "• Feeling irritable.\r\r"
        symptoms += "• Thoughts of hopelessness.\r\r"
        
        
        let sadnessVsDepression = "We all feel fed up, miserable or sad at times. These feelings do not usually last longer than a week or two, and they do not interfere too much with our lives. Sometimes there is a reason, sometimes not. We usually cope - we may talk to a friend but don't otherwise need any help.\r\rHowever, in depression your feelings do not lift after a few days – they carry on for weeks or months, and may be so bad that they interfere with your life.\r\rDepression can happen as a reaction to something like abuse, bullying or family breakdown, but it can also run in families. Depression often develops alongside anxiety. It can also affect your sleep and be a consequence of not getting enough quality sleep. Depression is one of the most common types of mental illness. Although it is hard to feel optimistic when you are depressed, there is lots of support available to help you feel better."
        
    let howToHandleItStr = "Visit our page on self care, talk to your family or a trusted adult in your school or community, or your GP about how you are feeling.  Try and eat regular meals, exercise and try to get regular sleep. Or if you would like to talk through what you are feeling with someone anonymously before speaking to someone you know there are many helplines and online chat systems that you can find going to Services under Mental health resources."

        dataModel = ["What is", "Symptoms", "Sadness VS Depression", "How to handle it"]
        
        dataContent = [descriptionStr,
                       symptoms,
                       sadnessVsDepression,
                       howToHandleItStr,]
        
         dataURLS = ["https://youngminds.org.uk/find-help/conditions/depression/","http://www.nhs.uk/Conditions/Depression/Pages/Symptoms.aspx","http://www.nhs.uk/Tools/Pages/depression.aspx","http://www.nhs.uk/NHSEngland/AboutNHSservices/mental-health-services-explained/Pages/accessing%20services.aspx",]
    }

}

//
//  AngerIssuesViewController.swift
//  Speak Out!
//
//  Created by admin on 06/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class AngerIssuesViewController: StackAnimatorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func changeDataModels() {
        
        var descriptionStr = "When you are growing up and going through your teenage years you feel a variety of emotions and it is normal and healthy to sometimes  feel angry.  Sometimes, young people feel angry and they don’t know why. It is important to do something with  these feelings and to express angry feelings in safe ways and not to keep them inside. Losing your temper can make things worse.\r\r"
        
        descriptionStr += "Difficulties with anger can also lead to other problems such as: depression, risky behaviour, refusing to go to school, becoming isolated, self-harm, drinking too much alcohol, or taking drugs.\r"
        
        var symptoms = "Anger can become an issue when you start:\r\r"
        symptoms +=  "• Hitting or physically hurting people.\r\r"
        symptoms += "• Breaking things.\r\r"
        symptoms += "• Mixing with people who get you in trouble.\r\r"
        symptoms += "• Losing control.\r\r"
        symptoms += "• Clenching fists and/or tensing muscles.\r\r"
        
        let howToHandleItStr = "Safe ways to express anger can be: exercise, punch a pillow, distract yourself, breathe, do calming rhythmical activities, listen to music, talk to someone about how you feel, or even watch comedy – you can't laugh and be angry at the same time.\r\rVisit our page on self care, talk to your family or a trusted adult in your school or community, or your GP about how you are feeling.  Try and eat regular meals, exercise and try to get regular sleep. Or if you would like to talk through what you are feeling with someone anonymously before speaking to someone you know there are many helplines and online chat systems that you can find going to Services."
        
        dataModel = ["What is", "Symptoms", "How to handle it"]
        
        dataContent = [descriptionStr,
                       symptoms,
                       howToHandleItStr,]
        
        dataURLS = ["https://www.youngminds.org.uk/find-help/feelings-and-symptoms/anger/","http://www.nhs.uk/Conditions/stress-anxiety-depression/Pages/about-anger.aspx","http://www.nhs.uk/Conditions/stress-anxiety-depression/Pages/controlling-anger.aspx",]
    }

}

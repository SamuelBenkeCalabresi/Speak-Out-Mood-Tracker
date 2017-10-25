
//
//  FirstAidViewController.swift
//  Speak Out!
//
//  Created by admin on 07/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class FirstAidViewController: StackAnimatorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func changeDataModels() {
        dataModel = ["Take a breath", "Mental health helplines", "Mental health websites", "Suicidal helplines"]
        
        var takeABreath = "Breathing is important, especially during an anxiety attack or when you feel overwhelmed with thoughts. "
        takeABreath += "A simple way to help control your breathing and calm your mind is to breathe in for five seconds and then breathe out for five seconds. Keep repeating this about four to six times, until you start to feel calmer. "
        takeABreath += "Another long term breathing exercise you can employ is the 4-7-8 breath.\r\r"
        takeABreath += "1. Sit comfortably in a straight up position.\r"
        takeABreath += "2. Place the tip of your tongue on the ridge of your gums, just under your front teeth.\r"
        takeABreath += "3. Expand your diaphragm and slowly inhale through your nose for a count of four.\r"
        takeABreath += "4. Hold your breath for another count of seven.\r"
        takeABreath += "5. Open your mouth slightly and exhale for eight counts, drawing your diaphragm in.\r"
        takeABreath += "6. Repeat this cycle four times in total.\r"
        
        var mentalHealthHelplines = "ChildLine: \r"
        mentalHealthHelplines += "• Tel: 0800 1111 \r"
        mentalHealthHelplines += "• Online and on the phone – 24/7.\r"
        mentalHealthHelplines += "• 1-2-1 online counsellor chat – BSL sign video option for counsellor chat (Monday to Friday, 9am to 6pm). \r"
        mentalHealthHelplines += "• Under 19’s Confidential service where they comfort, educate, and help young minds.\r"
        mentalHealthHelplines += "• Calls are free and the number will not show up on the phone bill.\r\r"
        
        mentalHealthHelplines += "Kooth: \r"
        mentalHealthHelplines += "• Free, safe and anonymous online support for young people. \r"
        mentalHealthHelplines += "• Monday to Friday 12pm-10pm.\r"
        mentalHealthHelplines += "• Saturday + Sunday 6pm-10pm. \r"
        mentalHealthHelplines += "• There to help with: being bullied, being physically or emotionally abused, not feeling accepted, low self-esteem, being stressed, feeling anxious, confused about sexuality, feeling depressed or alone.\r\r"
        
        mentalHealthHelplines += "7 Cups of Tea:\r"
        mentalHealthHelplines += "• Basic active listening service, self-help guides and some chat rooms do not require sign-up. \r"
        mentalHealthHelplines += "• Offers a free 24/7 active listening service where you can talk to someone confidentially about anything. Also, offers paid therapy services, self-help guides, guest, and member only chat rooms which are specific to certain issues and are moderated.\r"
        mentalHealthHelplines += "• Saturday + Sunday 6pm-10pm. \r"
        mentalHealthHelplines += "• There to help with: being bullied, being physically or emotionally abused, not feeling accepted, low self-esteem, being stressed, feeling anxious, confused about sexuality, feeling depressed or alone.\r\r"
        
        var mentalHealthWebsites = "ChildLine: \r "
        mentalHealthWebsites += "www.childline.org.uk\r\r"
        mentalHealthWebsites += "Samaritans: \r"
        mentalHealthWebsites += "www.samaritans.org\r\r"
        mentalHealthWebsites += "Kooth: \r"
        mentalHealthWebsites += "www.kooth.com\r\r"
        mentalHealthWebsites += "7 Cups of Tea: \r"
        mentalHealthWebsites += "www.7cups.com\r\r"
        
        var suicidalHelplines = "ChildLine: \r"
        suicidalHelplines += "• Tel: 0800 1111 \r"
        suicidalHelplines += "• Online and on the phone – 24/7.\r"
        suicidalHelplines += "• 1-2-1 online counsellor chat – BSL sign video option for counsellor chat (Monday to Friday, 9am to 6pm). \r"
        suicidalHelplines += "• Under 19’s Confidential service where they comfort, educate, and help young minds.\r"
        suicidalHelplines += "• Calls are free and the number will not show up on the phone bill.\r\r"
        
        suicidalHelplines += "Samaritans: \r"
        suicidalHelplines += "• Tel: 116 123/0208 961 6181 \r"
        suicidalHelplines += "• Email: jo@samaritans.org. \r"
        suicidalHelplines += "• Helpline for anyone to call – confidential.\r"
        suicidalHelplines += "• Online and on the phone – 24/7.\r"
        suicidalHelplines += "• Free to call.\r"
        
        dataContent = [takeABreath,
                       mentalHealthHelplines,
                       mentalHealthWebsites,
                       suicidalHelplines]
        
        dataURLS = ["http://www.nhs.uk", "http://www.nhs.uk",
                    "http://www.nhs.uk", "http://www.nhs.uk/Conditions/Suicide/Pages/Getting-help.aspx",]
    }
}

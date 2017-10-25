//
//  AnxietyViewController.swift
//  Speak Out!
//
//  Created by admin on 06/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class AnxietyViewController: StackAnimatorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func changeDataModels() {
        
        var descriptionStr = "Anxiety is a feeling of unease, worry or fear.\r\r"
        descriptionStr += "Everyone feels anxious, particularly in stressful situations.\r"
        descriptionStr += "Most people worry about something – money or exams – but once the difficult situation is over,  we start to feel better and calm down.  But when anxiety is severe, lasts for several weeks and includes symptoms that keep you from doing things you usually would, it may be something to discuss with your health care professional or to seek support  from someone at your school."
        descriptionStr += " Anxiety symptoms are real. They are not just in your head. They can be treated, and they are nothing to be ashamed of."
        
        var symptoms = "Symptoms may include feeling worried or uneasy a lot of the time, difficulty sleeping, not being able to concentrate, being irritable, feeling on edge and not being able to relax, feeling self conscious, avoidance of people or things. \r\r"
        symptoms += "Physical symptoms can include: \r\r"
        symptoms +=  "• A pounding heart.\r\r"
        symptoms += "• Breathing faster.\r\r"
        symptoms += "• Nausea. \r\r"
        symptoms += "• Feeling faint. \r\r"
        symptoms += "• Panic attacks.\r"
        
        var panickAttacksStr = "A panic attack happens when your body experiences a rush of intense psychological and physical symptoms."
        panickAttacksStr += " Panic attacks can last anywhere from 5 to 20 minutes."
        panickAttacksStr += " Symptoms may be: feeling unable to breathe, chest pains, pounding heartbeat, shaky limbs or jelly legs.\r\r"
        
        panickAttacksStr += "What should I do if I think I’m having a panic attack?\r"
        panickAttacksStr += "During one you may feel very afraid that you are losing control, you may feel faint or you feel you might be having a heart attack. But, even though having a panic attack can be a scary experience, it will pass and it is important to keep breathing, and it is important to breathe deeply and slowly; 5 seconds in and 5 seconds out. Go to Services for information about breathing."
        
        let howToHandleItStr = "Visit our page on self care, talk to your family or a trusted adult in your school or community, or your GP about how you are feeling.  Try and eat regular meals, exercise and try to get regular sleep. Or if you would like to talk through what you are feeling with someone anonymously before speaking to someone you know there are many helplines and online chat systems that you can find going to Services under Mental health resources."

        dataModel = ["What is", "Symptoms", "Panick attacks", "How to handle it",]
        
        dataContent = [descriptionStr,
                       symptoms,
                       panickAttacksStr,
                       howToHandleItStr,]
        
        dataURLS = ["https://youngminds.org.uk/find-help/conditions/anxiety/","http://www.nhs.uk/Conditions/Anxiety/Pages/Symptoms.aspx","http://www.nhs.uk/Conditions/stress-anxiety-depression/Pages/coping-with-panic-attacks.aspx","http://www.nhs.uk/NHSEngland/AboutNHSservices/mental-health-services-explained/Pages/accessing%20services.aspx",]
    }

}

//
//  SuicidalFeelingViewController.swift
//  Speak Out!
//
//  Created by admin on 03/07/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class SuicidalFeelingViewController: StackAnimatorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func changeDataModels() {
        
        var descriptionStr = "If you are feeling so down that you can’t see a way out, know that others have felt this way and survived. You are not alone and however bad you feel, you can be helped. Suicidal feelings are when a normal feeling of being very down and not sure where to turn become so deep and intense that the only solution seems to be to end your life.\r\r"
        descriptionStr += "Several things can lead up to suicidal feelings but it’s more likely if you’re:\r\r"
        descriptionStr += "- Depressed, or have another serious mental illness.\r"
        descriptionStr += "- Using drugs or alcohol, particularly if you’re upset.\r"
        descriptionStr += "- Very anxious about the future or today’s pressures.\r"
        descriptionStr += "- Under pressure from family or your peers.\r"
        descriptionStr += "Suicidal feelings can also dominate your ability to think so much that it makes it hard to understand that you can be helped, whatever the problem is."
        
        var symptoms = "Talking to someone can help you see beyond feelings of loneliness or despair and help you realise there are options. There are people who want to talk to you and help. Try talking to a family member or friend about how you're feeling.\r\r"
        symptoms += "Other people you could talk to, if you do not feel comfortable talking to family members, could be a teacher you trust, the school nurse, a faith leader, or even your GP.\r\r"
        symptoms +=  "There are several telephone helplines and online messaging services you can contact at any time, day, or night. You can speak to someone who understands how you're feeling and can help you through the immediate crisis. All these helplines can be found in the Services under Mental health resources.\r"
        symptoms +=  "• Go to your nearest A&E department and tell the staff how you are feeling.\r"
        symptoms +=  "• Contact NHS 111.\r"
        symptoms +=  "• Make an urgent appointment to see your GP.\r"

        
        var ifSomeoneIsFeeling = "There are many warning signs to spot in others who may be thinking about taking their own life. A few high-risk warning signs are:\r\r"
        ifSomeoneIsFeeling += "• A person threatening to hurt or kill themselves.\r"
        ifSomeoneIsFeeling += "• Talking/writing about death, dying and suicide in excessive amounts.\r"
        ifSomeoneIsFeeling += "• Actively looking for ways to kill themselves.\r"
        ifSomeoneIsFeeling += "• Complaining of feelings of hopelessness.\r"
        ifSomeoneIsFeeling += "• Talking/acting in a way that suggests their life has no sense of purpose.\r"
        ifSomeoneIsFeeling += "• Losing interest in most things, including their appearance.\r"
        ifSomeoneIsFeeling += "• Acting recklessly and engaging in risky activities with an apparent lack of concern for consequences.\r"
        ifSomeoneIsFeeling += "• Self-harming, or self-harming more than they might usually do.\r"
        ifSomeoneIsFeeling += "• Trouble sleeping and eating which gets progressively worse over time.\r"
        ifSomeoneIsFeeling += "• Becoming increasingly withdrawn from friends, family, and society in general.\r"

        var whoToTell = "In the case that you have spotted some of these warning signs there are many things you can do as their friend/family member to help them through this hard time. If there is an immediate danger to their life you should call 999. Take the young person to A&E where they can tell someone how they feel. One of the best things you can do if you think someone may be feeling suicidal is to encourage them to talk about their feelings and to listen to what they say.\r\r"
        whoToTell += "Talking about someone's problems is not always easy and it may be tempting to try to provide a solution. But often the most important thing you can do to help is listen to what they have to say. If there is an immediate danger, make sure they are not left on their own.\r\r"
        whoToTell += "Although talking to someone about their feelings can help them feel safe and secure, these feelings may not last. It will probably require long-term support to help someone overcome their suicidal thoughts. This will most likely be easier with professional help. Not only can a professional help deal with the underlying issues behind someone's suicidal thoughts, they can also offer advice and support for yourself.\r\r"
        whoToTell += "So, the next step might be getting them to talk to a teacher they trust, a family member, or even their GP, about what they are feeling. If you know the person who is having these suicidal feelings has previously been diagnosed with a mental illness you can contact a member of their care team or the centre or clinic where they were being treated if you, or a family member knows these details."
        whoToTell += "If you feel you need some help on how to approach this person you can talk to a teacher you trust or even a school nurse about the situation. If you want to get anonymous advice on what to do you can contact the NHS on the non-emergency number of 111.\r\r"
        
        
        dataModel = ["What they are", "What to do if you have them", "What to do if somone has them", "Who to contact",]
        
        dataContent = [descriptionStr,
                       symptoms,
                       ifSomeoneIsFeeling,
                       whoToTell,]
        
        dataURLS = [
            "http://www.nhs.uk/conditions/Suicide/Pages/Introduction.aspx",
            "https://youngminds.org.uk/find-help/feelings-and-symptoms/suicidal-feelings/",
            "http://www.nhs.uk/Conditions/Suicide/Pages/helping-others.aspx",
            "http://www.nhs.uk/Conditions/Suicide/Pages/Getting-help.aspx",]
    }


}

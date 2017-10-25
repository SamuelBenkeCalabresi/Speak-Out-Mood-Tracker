//
//  EatingDisorderViewController.swift
//  Speak Out!
//
//  Created by admin on 05/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class EatingDisorderViewController: StackAnimatorViewController {
    
    // Add the contents of the TextView inside the views for each new class
    // ie override a StackAnimator func that add the contents to the textView
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func changeDataModels() {
        
        let whatIsStr = "Problems with eating are not uncommon when you are stressed and worried about things and sometimes controlling what you eat can feel helpful when other areas of your life feel out of control. That could be eating not enough or sometimes eating too much.\r\rHowever sometimes, eating problems can get out of control and develop into eating disorders.\r"
        
        var descriptionStr = "The two main types of eating problems are Anorexia Nervosa and Bulimia.\r\r"
        descriptionStr += "• Anorexia nervosa:\r"
        descriptionStr += "Anorexia is an eating disorder where you worry about your weight, want to lose weight, and eat less and less food. It’s a serious condition, but with the right help, you can recover and take back your life.\r"
        descriptionStr += "• Bulimia:\r"
        descriptionStr += "Bulimia is an eating disorder where you get into a cycle of overeating and then making yourself sick to try control your weight.\r"
        
        var symptoms =  "The symptoms can change by the type of eating disorder.\r\r"
        symptoms += "• Anorexia nervosa:\r"
        symptoms += "- Missing meals.\r"
        symptoms += "- Losing a lot of weight very quickly.\r"
        symptoms += "- Obsessing over other people’s body size and comparing yourself to them.\r"
        symptoms += "- Feeling anxious or panicky about eating food with others.\r"
        symptoms += "- Thinking about calorie intake and excessive exercising.\r\r"
        symptoms += "• Bulimia:\r"
        symptoms += "- Binge eating.\r"
        symptoms += "- Some weight loss/weight gain.\r"
        symptoms += "- Vomiting or taking laxatives.\r"
        symptoms += "- Excessive exercise.\r"

       let howToHandleItStr = "Visit our page on self care, talk to your family or a trusted adult in your school or community, or your GP about how you are feeling.  Try and eat regular meals, exercise and try to get regular sleep. Or if you would like to talk through what you are feeling with someone anonymously before speaking to someone you know there are many helplines and online chat systems that you can find going to Services under Mental health resources."
        
        dataModel = ["What they are", "Types", "Symptoms", "How to handle it"]
        
        dataContent = [whatIsStr, descriptionStr, symptoms, howToHandleItStr,]
        
        dataURLS = ["http://www.nhs.uk/conditions/eating-disorders/pages/introduction.aspx","http://www.nhs.uk/conditions/Eating-disorders/Pages/Introduction.aspx#Types","http://www.nhs.uk/conditions/Eating-disorders/Pages/Introduction.aspx#Do-I-have-an-eating-disorder","http://www.nhs.uk/Livewell/Eatingdisorders/Pages/eatingdisordershomepage.aspx",]
    }
}

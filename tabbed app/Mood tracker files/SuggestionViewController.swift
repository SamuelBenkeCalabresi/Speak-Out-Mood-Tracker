//
//  SuggestionViewController.swift
//  Speak Out!
//
//  Created by admin on 08/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit
import CoreData

class SuggestionViewController: UIViewController {
    
    @IBOutlet weak var suggestionTextView: UITextView!
    @IBOutlet weak var awfulLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var okLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var radLabel: UILabel!
    
    @IBOutlet weak var happyQuote: UITextView!
    @IBOutlet weak var awfulButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var cheerfulButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    // DB Model to use
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let dbEntityName = "MoodsInDB3"
    let moodSentences = SuggestionSentences()
    var moodCounter = [0,0,0,0,0]
    var evaluationMood = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setEmotionButtons()
        evaluateMood()
        setMoodCounterLabels()
        chooseMood(with: evaluationMood)
    }
    
    override func viewDidLayoutSubviews() {
        happyQuote.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    func setMoodCounterLabels() {
        awfulLabel.text = String(moodCounter[0])
        badLabel.text = String(moodCounter[1])
        okLabel.text = String(moodCounter[2])
        goodLabel.text = String(moodCounter[3])
        radLabel.text = String(moodCounter[4])
    }
    
    func chooseMood(with evaluationMood: Int) {
        if evaluationMood <= -8 {
            giveHelpSuggestion()
        } else if evaluationMood >= -7, evaluationMood <= -1 {
            giveMessageCourage()
        } else if evaluationMood == 0 {
            giveMessageOk()
        } else if evaluationMood >= 1, evaluationMood <= 7 {
            giveGoodMessage()
        } else {
            giveGoodMessage()
        }
    }
    
    // Each func display message has multiple sentences that might be displayed. A random func decides which one.
    // Each sentence has one sentence of suggestion + inspirational sentence
    func giveHelpSuggestion() {
        let sentence1 = moodSentences.suggestHelp
        let sentence2 = moodSentences.suggestHelp
        let sentence3 = moodSentences.suggestHelp
        let sentence4 = moodSentences.suggestHelpSelfCare
        let dataForHelpSuggestion = [sentence1, sentence2, sentence3, sentence4,]
        suggestionTextView.text = getRandomSentence(from: dataForHelpSuggestion)
    }
    
    func giveMessageCourage() {
        let sentence1 = moodSentences.suggestHelpBarnet
        let sentence2 = moodSentences.suggestHelpServices
        let sentence3 = moodSentences.suggestHelpSelfCare
        let sentence4 = moodSentences.suggestHelpServices
        let dataForMessageCourage = [sentence1, sentence2, sentence3, sentence4,]
        suggestionTextView.text = getRandomSentence(from: dataForMessageCourage)
    }
    
    func giveMessageOk() {
        let sentence1 = moodSentences.suggestHelpSelfCare
        let sentence2 = moodSentences.suggestHelpSelfCare
        let sentence3 = moodSentences.messageOk
        let sentence4 = moodSentences.messageOk
        let dataForMessageOk = [sentence1, sentence2, sentence3, sentence4,]
        suggestionTextView.text = getRandomSentence(from: dataForMessageOk)
    }
    
    func giveGoodMessage() {
        let sentence1 = moodSentences.suggestHelpSelfCare
        let sentence2 = moodSentences.suggestHelpSelfCare
        let sentence3 = moodSentences.goodMessage
        let sentence4 = moodSentences.goodMessage
        let dataForGoodMessage = [sentence1, sentence2, sentence3, sentence4,]
        suggestionTextView.text = getRandomSentence(from: dataForGoodMessage)
    }
    
    // can get from core data DB instead of simple data structure
    func getRandomSentence(from dataModel: [String]) -> String {
        let randomSentence = dataModel[Int(arc4random_uniform(UInt32(dataModel.count)))]
        return randomSentence
    }
    
    // Place the code in here to be able update the view every time press on segmetend menu
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // This should be called every time the view for the calendar has to be rendered
    func evaluateMood() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbEntityName)
        request.returnsObjectsAsFaults = false
        do {
            var counter:Int = 0
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    counter += 1
                    // get attribute mood code from entity result
                    if let moodCode = result.value(forKey: "moodCode") as? String {
                        // switch to choose value is from
                        let moodCodeAsInt = Int(moodCode)!
                        print("THE moodCode is equal to \(moodCode)\r")
                        switch moodCodeAsInt {
                        case -2:
                            evaluationMood -= 2
                            moodCounter[0] += 1
                        case -1:
                            evaluationMood -= 1
                            moodCounter[1] += 1
                        case +0:
                            moodCounter[2] += 1
                        case +1:
                            evaluationMood += 1
                            moodCounter[3] += 1
                        case +2:
                            evaluationMood += 2
                            moodCounter[4] += 1
                        default:
                            moodCounter[0] = moodCounter[0]
                        }
                    }
                }
                print("THE NUMBER OF ENTRIES IN THE DB ARE: \(counter)")
            }
        } catch {
            // PROCESS ERROR
            print("ERROR FETCHING DATA")
        }
    }
    
    func setEmotionButtons() {
        // Set colours
        let moodColour = MoodColour()
        awfulButton.backgroundColor = moodColour.awfulColour
        badButton.backgroundColor = moodColour.badColour
        okButton.backgroundColor = moodColour.okColour
        goodButton.backgroundColor = moodColour.goodColour
        cheerfulButton.backgroundColor = moodColour.cheerfulColour
        
        // Set labels to shrink all in one line
        adjustFontSizeOf(button: awfulButton)
        adjustFontSizeOf(button: badButton)
        adjustFontSizeOf(button: okButton)
        adjustFontSizeOf(button: goodButton)
        adjustFontSizeOf(button: cheerfulButton)
    }
    
    func adjustFontSizeOf(button mybutton: UIButton) {
        mybutton.titleLabel?.minimumScaleFactor = 0.2
        mybutton.titleLabel?.numberOfLines = 1
        mybutton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
}

struct SuggestionSentences {
    
    let goodMessage = "It’s going great is it not? Keep going you’re doing great!\r\r"
    let messageOk = "Is it going all ok?! \r\r"
    let suggestHelp = "If you’re feeling low and you don’t know where to go, we have a list of helpful places and websites that can help you. You can go to Self Care in Services to understand some of the causes of why you're feeling low.\r\r"
    let suggestHelpBarnet = "There are contacts in the Community page that can be helpful for you.\r\r"
    let suggestHelpServices = "There are suggestions in the Self Care page that can be helpful for you to understand why you might be low.\r\r"
    let suggestHelpSelfCare = "There are suggestions in the Self Care page that can be helpful for you to understand why you might be low.\r\r"

}

struct MoodColour {
    let cheerfulColour = UIColor(colorWithHexValue: 0xFC767D)
    let goodColour = UIColor(colorWithHexValue: 0xFAC752)
    let okColour = UIColor(colorWithHexValue: 0xCA93FA)
    let badColour = UIColor(colorWithHexValue: 0x00B7F0)
    let awfulColour = UIColor(colorWithHexValue: 0x4531D1)
}



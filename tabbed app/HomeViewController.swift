//
//  FirstViewController.swift
//  tabbed app
//
//  Created by admin on 08/05/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var happyQuote: UITextView!
    @IBOutlet weak var awfulButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var cheerfulButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    // DB Model to use
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // Entity name in the DB model to be used in the VC
    let dbEntityName = "MoodsInDB3"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//         Change the style of the navigation bar app in only the home VC
        // To make this be sure to set the statust bar to lighter colours
//        self.navigationController?.navigationBar.barTintColor = UIColor.blue
//        self.navigationController?.navigationBar.tintColor = UIColor.blue
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //        return UIStatusBarStyle.lightContent
    //    }
    
    // Only functional in the functional testing phase
    func deleteAllRecordsInDatabase() {
        let context = appDelegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: dbEntityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("ERROR DELETING DATA")
        }
    }
    // Surgerying: add only a Mood = good on Date = 04/06/17
    func surgeryApplicationInDatabase() {
        let context = appDelegate.persistentContainer.viewContext
        let surgeryMood = NSEntityDescription.insertNewObject(forEntityName: dbEntityName, into: context)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        let date = formatter.date(from: "01-06-2017")
        
        let moodGood = "+1"
        
        surgeryMood.setValue(moodGood, forKey: "moodCode")
        surgeryMood.setValue(date, forKey: "created")
        // store new Mood
        do {
            try context.save()
            print("SAVED")
        } catch {
            // PROCESS ERROR
            print("ERROR CREATING NEW MOOD IN DB")
        }
    }

    // The viewDidLoad function will help to load everyhting required in the view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set content textView not editable
        happyQuote.isUserInteractionEnabled = true
        happyQuote.isEditable = false
        
        setEmotionButtons()
        
        let positiveQuotesDataModel = [
            "To succeed, you need to find something to hold on to, something to motivate you, something to inspire you.",
            "Happiness is a choice. You can choose to be happy. There's going to be stress in life, but it's your choice whether you let it affect you or not.",
            "Happiness is not something you postpone for the future; it is something you design for the present.",
            " Once you replace negative thoughts with positive ones, you'll start having positive results.",
            "You can't make positive choices for the rest of your life without an environment that makes those choices easy, natural, and enjoyable.",
            "Love yourself. It is important to stay positive because beauty comes from the inside out.",
            "When you think positive, good things happen.",
            "Believe in yourself! Have faith in your abilities! Without a humble but reasonable confidence in your own powers you cannot be successful or happy.",
            "Be happy for this moment. This moment is your life.",
            "Be happy with being you. Love your flaws. Own your quirks. And know that you are just as perfect as anyone else, exactly as you are.",
            "Dedicate yourself to the good you deserve and desire for yourself. Give yourself peace of mind. You deserve to be happy. You deserve delight.",
            "I think happiness is a choice. If you feel yourself being happy and can settle in to the life choices you make, then it's great. It's really, really great. I swear to God, happiness is the best makeup.",
            "Learning lessons is a little like reaching maturity. You're not suddenly more happy, wealthy, or powerful, but you understand the world around you better, and you're at peace with yourself. Learning life's lessons is not about making your life perfect, but about seeing life as it was meant to be.",
            "Positive thinking will let you do everything better than negative thinking will.",
            "The most difficult thing is the decision to act, the rest is merely tenacity. The fears are paper tigers. You can do anything you decide to do. You can act to change and control your life; and the procedure, the process is its own reward.",
        ]
        happyQuote.text = getRandomPositiveQuote(from: positiveQuotesDataModel)
    }
    
    // The segue is required to go to the new page with the preparation of the 
    // important variables to use (current mood colour == colour button)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        if let moodTrackerViewController = destinationViewController as? MoodTrackerViewController {
            //use in combination with moodCodes //let indentifier = segue.identifier {
            //this can be used for encoding & evaluation function //let mood = moodCodes[indentifier] {
            // prepare the segue
            if let button = sender as? UIButton {
                moodTrackerViewController.currentMoodColour = button.backgroundColor!
                moodTrackerViewController.isANewMoodCreated = true
            }
        }
    }
    
    // can get from core data DB instead of simple data structure
    func getRandomPositiveQuote(from dataModel: [String]) -> String {
        let random = dataModel[Int(arc4random_uniform(UInt32(dataModel.count)))]
        return random
    }
    
    func setEmotionButtons() {
        // Set colours
        awfulButton.backgroundColor = awfulColour
        badButton.backgroundColor = badColour
        okButton.backgroundColor = okColour
        goodButton.backgroundColor = goodColour
        cheerfulButton.backgroundColor = cheerfulColour
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

// string: identifier that come back from segue
// int: the code for evaluation function (or I could put the correspondent colour)
    let moodCodes: Dictionary<String,Int> = [
        "cheerful": +2,
        "good": +1,
        "ok": +0,
        "bad": -1,
        "awful": -2
    ]
    
    let cheerfulColour = UIColor(colorWithHexValue: 0xFC767D)
    let goodColour = UIColor(colorWithHexValue: 0xFAC752)
    let okColour = UIColor(colorWithHexValue: 0xCA93FA)
    let badColour = UIColor(colorWithHexValue: 0x00B7F0)
    let awfulColour = UIColor(colorWithHexValue: 0x4531D1)
    
    override func viewDidLayoutSubviews() {
        happyQuote.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
}

struct MoodSentences {
    let courageSent1 = "What the caterpillar calls the end of the world, the master calls a butterfly.\r"
    let courageSent2 = "And above all things, never think that you're not good enough yourself. A man should never think that. My belief is that in life people will take you at your own reckoning.\r"
    let courageSent3 = "Just as man cannot live without dreams, he cannot live without hope. If dreams reflect the past, hope summons the future.\r"
    let courageSent4 = "Health is the greatest gift, contentment the greatest wealth, faithfulness the best relationship.\r"
    
    let courageSent5 = "Change your thoughts and you change your world.\r"
    let courageSent6 = "If you believe in yourself and have dedication and pride - and never quit, you'll be a winner. The price of victory is high but so are the rewards.\r"
    let courageSent7 = "Thousands of candles can be lighted from a single candle, and the life of the candle will not be shortened. Happiness never decreases by being shared.\r"
    let courageSent8 = "If you always put limit on everything you do, physical or anything else. It will spread into your work and into your life. There are no limits. There are only plateaus, and you must not stay there, you must go beyond them.\r"
    
    let courageSent9 = "When you get into a tight place and everything goes against you, till it seems as though you could not hang on a minute longer, never give up then, for that is just the place and time that the tide will turn.\r"
    let courageSent10 = "Happiness is a butterfly, which when pursued, is always just beyond your grasp, but which, if you will sit down quietly, may alight upon you.\r"
    let courageSent11 = "Fall seven times, stand up eight.\r"
    let courageSent12 = "There are contact in the Services page that can be helpful.\r"
    
    let courageSent13 = "Everyone has inside of him a piece of good news. The good news is that you don't know how great you can be! How much you can love! What you can accomplish! And what your potential is!\r"
    let courageSent14 = "Tomorrow is the most important thing in life. Comes into us at midnight very clean. It's perfect when it arrives and it puts itself in our hands. It hopes we've learned something from yesterday.\r"
    let courageSent15 = "The most authentic thing about us is our capacity to create, to overcome, to endure, to transform, to love and to be greater than our suffering.\r"
    let courageSent16 = "Find out who you are and be that person. That's what your soul was put on this Earth to be. Find that truth, live that truth and everything else will come.\r"
}




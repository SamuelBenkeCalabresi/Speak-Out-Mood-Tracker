//  Created by Samuel Benke Calabresi on 08/05/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.

import UIKit
import JTAppleCalendar
import Foundation
import CoreData
    
class MoodTrackerViewController: UIViewController {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    let outsideMonthColour = UIColor(colorWithHexValue: 0xd4d6da)
    let monthColor = UIColor.black
    let selectedMonthColour = UIColor.white
    let currentDateSelectedViewColour = UIColor.white
    
    let formatter = DateFormatter()
    // Colour set by HomeViewController
    var currentMoodColour = UIColor.blue
    // Check if there is a new mood to add
    var isANewMoodCreated = false
    // DB Model to use
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let dbEntityName = "MoodsInDB3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Check if there is a new mood
        // If there is't the calendar has to be leaded anyway with all the DB
        // But without any update
        
        // Until the app is using only one month this is needed to remove moods from DB
        deleteOutsideMonthMoodsFromDatabase()
        
        if isANewMoodCreated == true {
            updateDatabase()
        }
        // Setup the labels in the VC
        setupCalendarView()
    }
    
    func deleteOutsideMonthMoodsFromDatabase() {
        
        let context = appDelegate.persistentContainer.viewContext
        let creationDate = NSDate()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {

                    if let date = result.value(forKey: "created") as? NSDate {
                        
                        let calendar = NSCalendar.current
                        
                        let monthStored = calendar.component(.month, from: date as Date)
                        
                        let currentMonth = calendar.component(.month, from: creationDate as Date)
                        
                        if monthStored != currentMonth {
                            
                            context.delete(result)
                            
                            try context.save()
                        }
                    }
                }
            }
        } catch {
            // PROCESS ERROR
            print("ERROR FETCHING DATA")
        }
    }
    
    // Update DB happens only if there is a new mood to be stored
    // Maximum number of moods to compare are 30
    func updateDatabase() {
        if isANewMoodCreated != true { return }
        let context = appDelegate.persistentContainer.viewContext
        let creationDate = NSDate()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbEntityName)
        var isNewMoodStored = false
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            // If there is already a mood on the same day then change and put the new one
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    // Check if the mood entry object is on the dame day
                    // otherwise is going to delete all the other entries
                    if let date = result.value(forKey: "created") as? NSDate {
                        let calendar = NSCalendar.current
                        // THE ERROR IS THAT IS STORES AN INT NOT A DATE
                        let dayStored = calendar.component(.day, from: date as Date)
                        let currentDay = calendar.component(.day, from: creationDate as Date)
                        // IF THE MOOD IS ON THE SAME DAY CHANGE IT TO THE LAST CREATED ONE
                        if dayStored == currentDay {
                            isNewMoodStored = true
                            let moodDecodedValue = decodeMoodValue()
                            result.setValue(moodDecodedValue, forKey: "moodCode")
                        }
                    }
                }
                // This happens most often: when in a new day the user wants to store his/her mood
                // But there wasn't another && there are other moods in the DB stored
                if isNewMoodStored != true {
                    let newMood = NSEntityDescription.insertNewObject(forEntityName: dbEntityName, into: context)
                    addMoodInDatabase(with: newMood, context: context, creationDate: creationDate)
                }
            }
            // This happens only once: when the DB is empty
            else {
                let newMood = NSEntityDescription.insertNewObject(forEntityName: dbEntityName, into: context)
                addMoodInDatabase(with: newMood, context: context, creationDate: creationDate)
            }
        } catch {
            // PROCESS ERROR
            print("ERROR FETCHING DATA")
        }
    }
    
    func addMoodInDatabase(with newMood: NSManagedObject, context: NSManagedObjectContext, creationDate: NSDate) {
        // Create a new mood // Decode mood value
        let moodDecodedValue = decodeMoodValue()
        newMood.setValue(moodDecodedValue, forKey: "moodCode")
        // this is should be the date mood picked this current day
        newMood.setValue(creationDate, forKey: "created")
        // store new Mood
        do {
            try context.save()
            print("SAVED")
        } catch {
            // PROCESS ERROR
            print("ERROR CREATING NEW MOOD IN DB")
        }
    }
    
    // This should be called every time the view for the calendar has to be rendered
    func fetchDatabaseAndSetMoods(currentCalendarCell: MoodCell) {
        let context = appDelegate.persistentContainer.viewContext
        // entity to search from
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbEntityName)
        // To get the full value from DB
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    setMoodColourOfCurrentCell(with: result, and: currentCalendarCell)
                }
            }
        } catch {
            // PROCESS ERROR
            print("ERROR FETCHING DATA")
        }
    }
    
    func setMoodColourOfCurrentCell(with fetchedMood: NSManagedObject, and currentCell: MoodCell) {
        if let date = fetchedMood.value(forKey: "created") as? NSDate {
            let calendar = NSCalendar.current
            // The problem is here. Because I'm returning only the Int of the day
            // without knowing month && year.
            let dayOfMood = calendar.component(.day, from: date as Date)
            let monthOfMood = calendar.component(.month, from: date as Date)
            let yearOfMood = calendar.component(.year, from: date as Date)
            
            let dateFromCalendar  = calendarView.visibleDates().monthDates.first!.date
            let monthFromCalendar = calendar.component(.month, from: dateFromCalendar)
            let yearFromCalendar = calendar.component(.year, from: dateFromCalendar)

            // Get the valid cell correspondent of the current day
            let intDateFromLabel = Int(currentCell.dateLabel.text!)
            
            // Set the background colour to decoded mood colour in DB
            if intDateFromLabel == dayOfMood && monthFromCalendar == monthOfMood && yearFromCalendar == yearOfMood {
                // Get only the current date of current month
                if currentCell.dateLabel.textColor != outsideMonthColour {
                    currentCell.selectedView.isHidden = false
                    
                    // MOOD CODE // NB: this can crash
                    if let moodCode = fetchedMood.value(forKey: "moodCode") as? String {
                        let moodColour = getMoodColour(with: moodCode)
                        currentCell.selectedView.backgroundColor = moodColour
                    }
                    // IF IN THE MONTH (IT HAS TO BE)
                    currentCell.dateLabel.textColor = selectedMonthColour
                }
            }
        }
    }
    
    func getMoodColour(with moodCode: String) -> UIColor {
        var moodColour: UIColor
        switch moodCode {
        case "-2":
            moodColour = awfulColour
        case "-1":
            moodColour = badColour
        case "+0":
            moodColour = okColour
        case "+1":
            moodColour = goodColour
        case "+2":
            moodColour = cheerfulColour
        default:
            moodColour = UIColor.white
        }
        return moodColour
    }
    
    func decodeMoodValue() -> String {
        var moodDecodedValue: String
        switch currentMoodColour {
        case awfulColour:
            moodDecodedValue = "-2"
        case badColour:
            moodDecodedValue = "-1"
        case okColour:
            moodDecodedValue = "+0"
        case goodColour:
            moodDecodedValue = "+1"
        case cheerfulColour:
            moodDecodedValue = "+2"
        default:
            moodDecodedValue = " "
        }
        return moodDecodedValue
    }
    
    func handleCellTextColour(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? MoodCell else {
            return
        }
        if cellState.isSelected {
            validCell.dateLabel.textColor = selectedMonthColour
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor
            } else {
                validCell.dateLabel.textColor = outsideMonthColour
            }
        }
    }
    
    func setupCalendarView() {
        // Setup views
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        // Setup labels
        calendarView.visibleDates() { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date  = visibleDates.monthDates.first!.date
        
        // SET UP LABELS
        self.formatter.dateFormat =  "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat =  "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }

    
    // NB: to be placed in its own data structure
    let cheerfulColour = UIColor(colorWithHexValue: 0xFC767D)
    let goodColour = UIColor(colorWithHexValue: 0xFAC752)
    let okColour = UIColor(colorWithHexValue: 0xCA93FA)
    let badColour = UIColor(colorWithHexValue: 0x00B7F0)
    let awfulColour = UIColor(colorWithHexValue: 0x4531D1)
}

extension MoodTrackerViewController: JTAppleCalendarViewDataSource {
        func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
            formatter.dateFormat = "dd-MM-yyyy"
            formatter.timeZone = Calendar.current.timeZone
            formatter.locale = Calendar.current.locale
            
            // for now use just one month with core data (one month at the time)
            let date = Date()
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: date)
            // This can crash the app
            let startOfMonth = Calendar.current.date(from: comp)!
            var comps2 = DateComponents()
            comps2.month = 1
            comps2.day = -1
            let endOfMonth = Calendar.current.date(byAdding: comps2, to: startOfMonth)!
            
            let parameters = ConfigurationParameters(startDate: startOfMonth, endDate: endOfMonth)
            return parameters
        }
}

extension MoodTrackerViewController: JTAppleCalendarViewDelegate {
    // Display the cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "MoodCell", for: indexPath) as! MoodCell
        
        cell.dateLabel.text = cellState.text
        cell.dateLabel.isHidden = false
        
//        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColour(view: cell, cellState: cellState)
        fetchDatabaseAndSetMoods(currentCalendarCell: cell)
        
//        changeCellColourByMood(validCell: cell)
        return cell
    }
    
    // called whenever the user scroll. used to set month and year label
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
        
    }
}

// Extension for hexadecimal number colours
extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0) {
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
            
        )
    }
}

// It doesn't work if it set label in other languages
struct MonthNumbers {
    let January = 1
    let February = 2
    let March = 3
    let April = 4
    
}


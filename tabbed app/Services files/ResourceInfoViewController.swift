//
//  ResourceInfoViewController.swift
//  Speak Out!
//
//  Created by admin on 25/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class ResourceInfoViewController: UIViewController {
    
    var mentalHealthResource: MentalHealthResource!
    
    @IBOutlet var backgroundColoredViews: [UIView]!
    @IBOutlet var headingLabels: [UILabel]!
    
    @IBOutlet weak var whyVisitLabel: UILabel!
    @IBOutlet weak var whatToSeeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Clear background colors from labels and buttons
        for view in backgroundColoredViews {
            view.backgroundColor = UIColor.clear
        }
        
        // Set the kerning to 1 to increase spacing between letters
        headingLabels.forEach { $0.attributedText = NSAttributedString(string: $0.text!, attributes: [NSKernAttributeName: 1]) }
        
        title = mentalHealthResource.name
        
        whyVisitLabel.text = mentalHealthResource.whyVisit
        
        if mentalHealthResource.number != "/" {
            whatToSeeLabel.text = "Telephone: \(mentalHealthResource.number)\r"
        } else {
            whatToSeeLabel.text = " "
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func wikipediaButtonTapped(_ sender: UIButton) {
            openWebsiteInSafari(with: mentalHealthResource.wikipediaURL)
    }
        
    func openWebsiteInSafari(with link:URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(link)
        } else {
            UIApplication.shared.openURL(link)
        }
    }
    
    @IBAction func callButtonTapped(_ sender: UIButton) {
        if mentalHealthResource.number == "/" {
            whatToSeeLabel.text = "The Service is only online."
        } else {
            var uc = URLComponents()
            uc.scheme = "tel"
            uc.path = mentalHealthResource.number
            guard let number = uc.url else { return }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number)
            } else {
                UIApplication.shared.openURL(number)
            }
        }
    }
    
}

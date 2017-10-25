//
//  LocationInfoViewController.swift
//  Speak Out!
//
//  Created by admin on 23/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit
import MapKit

class LocationInfoViewController: UIViewController {
    
    var location: Location!
    
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
        
        title = location.name
        
        whyVisitLabel.text = location.whyVisit
        
        if location.number != "/", location.email != "/"  {
            whatToSeeLabel.text = "Telephone: \(location.number)\rEmail: \(location.email)"
        } else if location.number != "/" && location.email == "/" {
            whatToSeeLabel.text = "Telephone: \(location.number)"
        } else if location.email != "/" && location.number == "/" {
            whatToSeeLabel.text = "Email: \(location.email)"
        } else {
            whatToSeeLabel.text = "View information online."
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func openMapTapped(_ sender: UIButton) {
        if location.coordinate.latitude == 0 && location.coordinate.longitude == 0 {
            whatToSeeLabel.text = "The service does not have an address.\rView information online to know more."
        } else {
            let coordinates = location.coordinate
            let regionDistance: CLLocationDistance = 1000;
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = location.name
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
    @IBAction func wikipediaButtonTapped(_ sender: UIButton) {
        openWebsiteInSafari(with: location.wikipediaURL)
    }
    
    func openWebsiteInSafari(with link:URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(link)
        } else {
            UIApplication.shared.openURL(link)
        }
    }
}

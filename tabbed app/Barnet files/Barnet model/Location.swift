//
//  VacationSpot.swift
//  Speak Out!
//
//  Created by admin on 22/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import Foundation
import MapKit

struct Location {
    let identifier: Int
    let name: String
    let locationName: String
    let thumbnailName: String
    let whyVisit: String
    let wikipediaURL: URL
    let coordinate: CLLocationCoordinate2D
    let number: String
    let email: String
}

// MARK: - Support for loading data from plist

extension Location {
    
    static func loadAllVacationSpots() -> [Location] {
        return loadVacationSpotsFromPlistNamed("locations")
    }
    
    fileprivate static func loadVacationSpotsFromPlistNamed(_ plistName: String) -> [Location] {
        guard
            let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
            let dictArray = NSArray(contentsOfFile: path) as? [[String : AnyObject]]
            else {
                fatalError("An error occurred while reading \(plistName).plist")
        }
        
        var vacationSpots = [Location]()
        
        for dict in dictArray {
            guard
                let identifier    = dict["identifier"]    as? Int,
                let name          = dict["name"]          as? String,
                let locationName  = dict["locationName"]  as? String,
                let thumbnailName = dict["thumbnailName"] as? String,
                let whyVisit      = dict["whyVisit"]      as? String,
                let wikipediaLink = dict["wikipediaLink"] as? String,
                let latitude      = dict["latitude"]      as? Double,
                let longitude     = dict["longitude"]     as? Double,
                let number        = dict["number"]        as? String,
                let email         = dict["email"]         as? String
                else {
                    fatalError("Error parsing dict \(dict)")
            }
            
            let wikipediaURL = URL(string: wikipediaLink)!
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let vacationSpot = Location(
                identifier: identifier,
                name: name,
                locationName: locationName,
                thumbnailName: thumbnailName,
                whyVisit: whyVisit,
                wikipediaURL: wikipediaURL,
                coordinate: coordinate,
                number: number,
                email: email
            )
            vacationSpots.append(vacationSpot)
        }
        return vacationSpots
    }
}

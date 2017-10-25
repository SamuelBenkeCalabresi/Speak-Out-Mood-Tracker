//
//  MentalHealthResource.swift
//  Speak Out!
//
//  Created by admin on 25/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import Foundation
import MapKit

struct MentalHealthResource {
    let identifier: Int
    let name: String
    let locationName: String
    let thumbnailName: String
    let whyVisit: String
    let wikipediaURL: URL
    let number: String
}

// MARK: - Support for loading data from plist

extension MentalHealthResource {
    
    static func loadAllVacationSpots() -> [MentalHealthResource] {
        return loadVacationSpotsFromPlistNamed("mentalHealthResources")
    }
    
    fileprivate static func loadVacationSpotsFromPlistNamed(_ plistName: String) -> [MentalHealthResource] {
        guard
            let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
            let dictArray = NSArray(contentsOfFile: path) as? [[String : AnyObject]]
            else {
                fatalError("An error occurred while reading \(plistName).plist")
        }
        
        var resources = [MentalHealthResource]()
        
        for dict in dictArray {
            guard
                let identifier    = dict["identifier"]    as? Int,
                let name          = dict["name"]          as? String,
                let locationName  = dict["locationName"]  as? String,
                let thumbnailName = dict["thumbnailName"] as? String,
                let whyVisit      = dict["whyVisit"]      as? String,
                let wikipediaLink = dict["wikipediaLink"] as? String,
                let number =        dict["number"]        as? String
                else {
                    fatalError("Error parsing dict \(dict)")
            }
            
            let wikipediaURL = URL(string: wikipediaLink)!
            let resource = MentalHealthResource(
                identifier: identifier,
                name: name,
                locationName: locationName,
                thumbnailName: thumbnailName,
                whyVisit: whyVisit,
                wikipediaURL: wikipediaURL,
                number: number
            )
            resources.append(resource)
        }
        return resources
    }
}

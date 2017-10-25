//
//  MapOfBarnetViewController.swift
//  Speak Out!
//
//  Created by admin on 08/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class MapOfBarnetViewController: UITableViewController {

    var locations = [Location]()
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        locations = Location.loadAllVacationSpots()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpfulLocationCell", for: indexPath) as! HelpfulLocationCell
        let vacationSpot = locations[indexPath.row]
        cell.nameLabel.text = vacationSpot.name
        cell.locationNameLabel.text = vacationSpot.locationName
        cell.thumbnailImageView.image = UIImage(named: vacationSpot.thumbnailName)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedCell = sender as? UITableViewCell, let selectedRowIndex = tableView.indexPath(for: selectedCell)?.row, segue.identifier == "showLocationViewController" else {
            fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
        
        let location = locations[selectedRowIndex]
        let detailViewController = segue.destination as! LocationInfoViewController
        detailViewController.location = location

    }
}

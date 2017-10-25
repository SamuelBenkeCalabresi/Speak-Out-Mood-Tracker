//
//  MentalHealthResourcesViewController.swift
//  Speak Out!
//
//  Created by admin on 25/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class MentalHealthResourcesViewController: UITableViewController {
    
    var mentalHealthResources = [MentalHealthResource]()
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mentalHealthResources = MentalHealthResource.loadAllVacationSpots()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentalHealthResources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MentalHealthResourceCell", for: indexPath) as! MentalHealthResourceCell
        let vacationSpot = mentalHealthResources[indexPath.row]
        cell.nameLabel.text = vacationSpot.name
        cell.locationNameLabel.text = vacationSpot.locationName
        cell.thumbnailImageView.image = UIImage(named: vacationSpot.thumbnailName)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedCell = sender as? UITableViewCell, let selectedRowIndex = tableView.indexPath(for: selectedCell)?.row, segue.identifier == "showResourceViewController" else {
            fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
        
        let mentalHealthRes = mentalHealthResources[selectedRowIndex]
        let detailViewController = segue.destination as! ResourceInfoViewController
        detailViewController.mentalHealthResource = mentalHealthRes
    }
    
}

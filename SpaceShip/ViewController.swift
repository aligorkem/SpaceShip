//
//  ViewController.swift
//  SpaceShip
//
//  Created by Ali Gorkem Ozturk on 13/3/22.
//


import UIKit

/// This is a ViewController class of TableView Component
class ViewController: UITableViewController {
    var vehicles = [Vehicle]()
    
    /// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://swapi.dev/api/starships"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parseJsonData(json: data)
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(vehicles) {
                    UserDefaults.standard.setValue(encoded, forKey: "vehicles")
                }
                
                return
            }
        }
        displayErrors()
    }
    
    /// This function parses the fetched json data
    /// - Parameter json: fetched data
    func parseJsonData(json: Data) {
        let decoder = JSONDecoder()

        if let jsonVehicles = try? decoder.decode(Vehicles.self, from: json) {
            vehicles = jsonVehicles.results
            tableView.reloadData()
        }
    }
    
    /// It returns the Vehicles count
    /// - Parameters:
    ///   - tableView: tableView
    ///   - section: section
    /// - Returns: Vehicles Count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let vehicle = vehicles[indexPath.row]
        cell.textLabel?.tag = indexPath.row
        cell.textLabel?.text = vehicle.manufacturer
        cell.detailTextLabel?.text = vehicle.name
        
        return cell;
    }

    
    /// Displays error if there is an unexpected issue occurs
    func displayErrors() {
        let alertController = UIAlertController(title: "Loading error", message: "There was a problem while loading the data", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let userDefaults = UserDefaults.standard
        let selectedIndexRow = indexPath.row
        var indexes: [Int] = userDefaults.object(forKey: "favourites") as? [Int] ?? []
        
        let favouriteButton : UIContextualAction
        if !indexes.contains(indexPath.row) {
            favouriteButton = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
                if !indexes.contains(selectedIndexRow){
                    indexes.insert(selectedIndexRow, at: 0)
                    userDefaults.setValue(indexes, forKey: "favourites")
                    tableView.reloadData()
                }
            }
            favouriteButton.image = UIImage(systemName: "star.fill")
            favouriteButton.backgroundColor =  .systemGreen
        } else {
            favouriteButton = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
                if indexes.contains(selectedIndexRow){
                    indexes.remove(at: indexes.firstIndex(of: selectedIndexRow)!)
                    userDefaults.setValue(indexes, forKey: "favourites")
                    tableView.reloadData()
                }
            }
            favouriteButton.image = UIImage(systemName: "star")
            favouriteButton.backgroundColor =  .systemRed
        }
        let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [favouriteButton])
        return swipeActionsConfiguration
    }
    
    /// It prepares the details controller
    /// - Parameters:
    ///   - segue: segue
    ///   - sender: sender
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            let detailViewController: DetailViewController? = segue.destination as? DetailViewController
            let cell: UITableViewCell? = sender as? UITableViewCell
            if cell != nil {
                let row = (cell?.textLabel!.tag)!
                let vehicle = vehicles[row]
                detailViewController!.selectedVehicle = vehicle
                detailViewController!.selectedIndexRow = row
            }
        }
    }
}



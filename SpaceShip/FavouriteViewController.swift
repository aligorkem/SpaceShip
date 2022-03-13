//
//  ViewController.swift
//  SpaceShip
//
//  Created by Ali Gorkem Ozturk on 13/3/22.
//


import UIKit

class FavouriteViewController: UITableViewController {
    var vehicles = [Vehicle]()
    var favourites: [Int] = []

    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        favourites = (UserDefaults.standard.object(forKey: "favourites") as? [Int] ?? [])!
        if let savedVehicles = UserDefaults.standard.object(forKey: "vehicles") as? Data {
            let decoder = JSONDecoder()
            if let _vehicles = try? decoder.decode([Vehicle].self, from: savedVehicles) {
                vehicles.removeAll();
                for index in favourites{
                    vehicles.append(_vehicles[index])
                }
            }
        }
        
        tableView.reloadData()
    }

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            let detailViewController: DetailViewController? = segue.destination as? DetailViewController
            let cell: UITableViewCell? = sender as? UITableViewCell
            if cell != nil {
                let row = (cell?.textLabel!.tag)!
                let vehicle = vehicles[row]
                detailViewController!.selectedVehicle = vehicle
                detailViewController!.selectedIndexRow = favourites[row]
            }
        }
    }
}



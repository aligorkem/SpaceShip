//
//  DetailViewController.swift
//  SpaceShip
//
//  Created by Ali Gorkem Ozturk on 13/3/22.
//


import UIKit
 
/// This is a ViewController class of DetailViewController
class DetailViewController: UIViewController {
    
    /// Selected Vehicle
    var selectedVehicle: Vehicle?
    
    /// Selected Index
    var selectedIndexRow: Int?
    
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var crew: UILabel!
    @IBOutlet weak var passangers: UILabel!
    @IBOutlet weak var cargoCapacity: UILabel!
    @IBOutlet weak var consumables: UILabel!
    @IBOutlet weak var hyperDriveRatinf: UILabel!
    @IBOutlet weak var mglt: UILabel!
    @IBOutlet weak var starshipClass: UILabel!
    
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    
    override func viewDidLoad(){
        super.viewDidLoad();
    }
    
    /// It sets the params when the view is about to appear on screen
    /// - Parameter animated: animated
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.model.text = selectedVehicle!.model
        self.manufacturer.text = selectedVehicle!.manufacturer
        self.cost.text = selectedVehicle!.cost_in_credits
        self.length.text = selectedVehicle!.length
        self.speed.text = selectedVehicle!.max_atmosphering_speed
        self.crew.text = selectedVehicle!.crew
        self.passangers.text = selectedVehicle!.passengers
        self.cargoCapacity.text = selectedVehicle!.cargo_capacity
        self.consumables.text = selectedVehicle!.consumables
        self.hyperDriveRatinf.text = selectedVehicle!.hyperdrive_rating
        self.mglt.text = selectedVehicle!.model
        self.starshipClass.text = selectedVehicle!.model
        
        let indexes: [Int] = UserDefaults.standard.object(forKey: "favourites") as? [Int]  ?? []
        if !indexes.contains(selectedIndexRow!){
            favouriteButton.image = UIImage(systemName: "star.fill")
        } else {
            favouriteButton.image = UIImage(systemName: "star")
        }
    }
    
    @IBAction func addFavourite(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        var indexes: [Int] = userDefaults.object(forKey: "favourites") as? [Int]  ?? []
        if !indexes.contains(selectedIndexRow!){
            indexes.insert(selectedIndexRow!, at: 0)
            userDefaults.setValue(indexes, forKey: "favourites")
            favouriteButton.image = UIImage(systemName: "star")
        } else {
            indexes.remove(at: indexes.firstIndex(of: selectedIndexRow!)!)
            userDefaults.setValue(indexes, forKey: "favourites")
            favouriteButton.image = UIImage(systemName: "star.fill")
        }
    }
}

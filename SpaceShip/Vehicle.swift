//
//  Vehicle.swift
//  SpaceShip
//
//  Created by Ali Gorkem Ozturk on 13/3/22.
//

import Foundation

/// This class represents a vehicle
struct Vehicle: Codable {
    var name: String
    var model: String
    var manufacturer: String
    var cost_in_credits: String
    var length: String
    var max_atmosphering_speed: String
    var crew: String
    var passengers: String
    var cargo_capacity: String
    var consumables: String
    var hyperdrive_rating: String
    var MGLT: String
    var starship_class: String
}

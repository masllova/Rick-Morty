//
//  Model.swift
//  Rick&Morty
//
//  Created by Александра Маслова on 17.08.2023.
//

import Foundation

struct Personage {
    let id: Int
    let name: String
    let image: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin: Origin?
    let episodes: [Episode]
}

struct Origin {
    let id: Int
    let name: String
    let type: String
}

struct Episode {
    let id: Int
    let name: String
    let airDate: String
    let episodeCode: String
}

// MARK: enums

enum Status: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum Species: String {
    case human = "Human"
    case alien = "Alien"
    case unknown = "unknown"
}

enum Gender: String {
    case male = "Male"
    case female = "Female"
    case unknown = "unknown"
}

// MARK: Keys

enum Keys {
    case results
    case id
    case name
    case image
    case status
    case species
    case type
    case gender
    case origin
    case episodes
    case episode
    case residents
    case air_date
}

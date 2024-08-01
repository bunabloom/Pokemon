//
//  Model.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import Foundation
struct Constants {
  let imageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/54.png"
  
  
}



// MARK: - PokemonModel






struct PokemonModel: Codable {
    let id: Int?
    let name: String?
    let types: [TypeElement]?
    let height, weight: Int?

}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int?
    let type: TypeType
}

// MARK: - TypeType
struct TypeType: Codable {
    let name: String
    let url: String
}


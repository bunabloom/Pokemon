//
//  Model.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import Foundation
struct Constants {
  
  
  
}



// MARK: - PokemonModelDetailInfo

struct PokemonModel: Codable {
    let id: Int?
    let name: String?
    let types: [TypeElement]?
    let height, weight: Int?
}

struct TypeElement: Codable {
    let type: TypeType
}

struct TypeType: Codable {
    let name: String
}


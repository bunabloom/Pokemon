//
//  Model.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import Foundation
//포켓몬의 리스트를 가져오기위함
struct PokemonResponse: Codable {
  let results: [ResponseResult]
}
struct ResponseResult: Codable {
  let name: String?
  let url: String?
  
  var pokemonID: String {
      guard let url = url else { return "" }
      let components = url.split(separator: "/")
      if let lastComponent = components.last, let id = Int(lastComponent) {
          return String(id)
      }
      return ""
  }
}
struct PokemonModel: Codable {
    let id: Int?
    let name: String?
    let types: [TypeElement]?
  let height: Float?
  let weight: Float?
}

struct TypeElement: Codable {
    let type: TypeType
}

struct TypeType: Codable {
    let name: PokemonTypeName
  
}





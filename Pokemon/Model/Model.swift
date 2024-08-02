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
    guard let id = url else { return "ID없음"}
    let temp = id.index(id.endIndex, offsetBy: -2)
    //print(id[temp])
    return String(id[temp])
  }
}
// 여기에서 가지고 온 url을 가지고 다시 fetch 작업을 해서 이미지를 가져올것임
// 일단 


///디테일한 정보를 가져오기 위함
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


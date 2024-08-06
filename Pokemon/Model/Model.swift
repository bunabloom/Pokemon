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
      
      // URL을 "/"로 분할하여 배열 생성
      let components = url.split(separator: "/")
      
      // 마지막 구성 요소가 숫자인지 확인하고 반환
      if let lastComponent = components.last, let id = Int(lastComponent) {
          return String(id)
      }
      
      return ""
  }
}
// 여기에서 가지고 온 url을 가지고 다시 fetch 작업을 해서 이미지를 가져올것임
// 일단 


///디테일한 정보를 가져오기 위함
struct PokemonModel: Codable {
    let id: Int?
    let name: String?
    let types: [TypeElement]?
  let height: Int?
  let weight: Int?
}

struct TypeElement: Codable {
    let type: TypeType
}

struct TypeType: Codable {
    let name: PokemonTypeName
  
}



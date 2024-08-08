//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by bloom on 8/2/24.
//

import Foundation
import RxSwift

final class DetailViewModel {
  let pokemonDetailSubject = PublishSubject<PokemonModel>()
  private let disposeBag = DisposeBag()
  var pokemonID: String
  lazy var urlString =  "https://pokeapi.co/api/v2/pokemon/\(pokemonID)/"
  //enum 사용해서 urlstring query "케이스별로"
  

  
  init(pokemonID: String){
    self.pokemonID = pokemonID

  }
  
  func fetchPokeDetailData(){
    
    guard let url = URL(string: urlString)
    else { pokemonDetailSubject
      .onError(NetworkError.dataFetchFail)
      return
    }
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: {[weak self] (pokemonModel:PokemonModel) in
        self?.pokemonDetailSubject.onNext(pokemonModel)
      },
                 onFailure: {[weak self] error in
        self?.pokemonDetailSubject.onError(error)
      }).disposed(by: disposeBag)
  }
}

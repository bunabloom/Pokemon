//
//  ViewModel.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import UIKit
import RxSwift

final class MainViewModel {
  
  private var isRequest = false
  private var offset = 0
  private let disposeBag = DisposeBag()
  private var urlString : String{ return "https://pokeapi.co/api/v2/pokemon?limit=20&offset=\(offset)" }
  let pokemonSubject = BehaviorSubject(value:[ResponseResult]())
  
  init(){
    fetchPokeData()
  }
  
  final func fetchPokeData(){
    guard isRequest != true else { return }
    isRequest = true
    guard let url = URL(string: urlString)
    else {
      pokemonSubject.onError(NetworkError.dataFetchFail)
      return
    }
      NetworkManager.shared.fetch (url: url)
        .subscribe(onSuccess: {[weak self] (pokeResponse: PokemonResponse) in
          self?.pokemonSubject.onNext(pokeResponse.results)
          self?.isRequest = false
          self?.offset += 20
       },
                   onFailure: {[weak self] error in
          self?.pokemonSubject.onError(error)
          self?.isRequest = false
        }).disposed(by: disposeBag)
  }
}




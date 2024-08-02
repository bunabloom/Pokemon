//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by bloom on 8/2/24.
//

import Foundation
import RxSwift

class DetailViewModel {
  
  let pokemonDetailSubject = PublishSubject<PokemonModel>()
  private let disposeBag = DisposeBag()
  
  lazy var detailDomain = "https://pokeapi.co/api/v2/pokemon/\(pokemonID)/"
  
  var pokemonID:String
  
  // 뷰디드 로드시점에 함수로 호출한다던지
  
  
  init(pokemonID: String){
    self.pokemonID = pokemonID
    fetchPokeDetailData()
  }
  
  
  
  
  func fetchPokeDetailData(){
    
    guard let url = URL(string: detailDomain)
    else{ pokemonDetailSubject.onError(NetworkError.dataFetchFail) ; return }
    print(url)
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: {[weak self] (pokemonModel:PokemonModel) in
        print(#function,pokemonModel)
        self?.pokemonDetailSubject.onNext(pokemonModel)
        
      }, onFailure: {[weak self] error in
        print(#function,error)
        self?.pokemonDetailSubject.onError(error)
      }).disposed(by: disposeBag)
    print(disposeBag)
          
    
  }
}

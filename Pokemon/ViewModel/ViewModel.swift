//
//  ViewModel.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import UIKit
import RxSwift

///비즈니스 로직: 포켓몬의 이미지를 보여주고, 클릭시 디테일한 정보를 보여주는
/// 독립적이여야함  
// 고민해봐야할부분 -> 데이터를 불러오더라도 150개까지 어떻게 불러올지
///데이터를 어떻게 받아와야할지
///
///
///
///
class PokemonViewModel {
  private let disposeBag = DisposeBag()
  let domainString = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
  
  let pokemonSubject = BehaviorSubject(value:[ResponseResult]())

  
  init(){
    fetchPokeData()
  }
  
  func fetchPokeData(){
    guard let url = URL(string: domainString)
    else{ pokemonSubject.onError(NetworkError.dataFetchFail); return }
    
    NetworkManager.shared.fetch (url: url)
      .subscribe(onSuccess: {[weak self] (pokeResponse:PokemonResponse) in

        //print("Singleton Data fetch Success",pokeResponse)
        self?.pokemonSubject.onNext(pokeResponse.results)},
                 onFailure: {[weak self] error in
        //print("Singleton Data fetch Failure",error)
        self?.pokemonSubject.onError(error)}).disposed(by: disposeBag)
      
      

  }
  func fetchPokeimage(){
    
  }
  
}

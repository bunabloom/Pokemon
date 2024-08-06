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
final class MainViewModel {
  
  var isRequest = false
  /// 디테일에 필요한 정보
  var offset = 0
  // 오프셋을 추가해서 재호출해야함
  private let disposeBag = DisposeBag()
  var domainString : String{ return "https://pokeapi.co/api/v2/pokemon?limit=20&offset=\(offset)" }
  let pokemonSubject = BehaviorSubject(value:[ResponseResult]())
  
  init(){
    fetchPokeData()
  }
  
  final func fetchPokeData(){
    guard isRequest != true else { return }
    isRequest = true
    
    guard let url = URL(string: domainString)
    
            
    else{
      pokemonSubject.onError(NetworkError.dataFetchFail)
      return
    }
    print(url)
    
      
      NetworkManager.shared.fetch (url: url)
        .subscribe(onSuccess: {[weak self] (pokeResponse:PokemonResponse) in
          print("Singleton Data fetch Success",pokeResponse)
          self?.pokemonSubject.onNext(pokeResponse.results)
          self?.isRequest = false
          self?.offset += 20
       },
                   onFailure: {[weak self] error in
          //print("Singleton Data fetch Failure",error)
          self?.pokemonSubject.onError(error)
          self?.isRequest = false
        }).disposed(by: disposeBag)
      
    
    
  }
  
  
  

  
}




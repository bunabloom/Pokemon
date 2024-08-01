//
//  NetworkManager.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import Foundation
import RxSwift

enum NetworkError: Error {
  case invalidUrl
  case dataFetchFail
  case decodingFail
}

class NetworkManager {
  static let shared = NetworkManager()
  
  private init() {}
  
  func fetch<T: Decodable>(url: URL) -> Single<T> {
    return Single.create(subscribe: {
      observer in
      
      let session = URLSession(configuration: .default)
      
      session.dataTask(with: URLRequest(url: url)) {
        data, response, error in
        
        if let error = error { observer( .failure(error) )
          return }
        
        guard let data = data,
              let response = response as? HTTPURLResponse,(200..<300).contains(response.statusCode)
                
        else {
          if let response = response as? HTTPURLResponse {
            print(#function,"StatusCode:",response.statusCode)
          }
          observer( .failure(NetworkError.dataFetchFail) )
          return
        }
        
        do {
          let decodeData = try JSONDecoder().decode(T.self, from: data)
          observer(.success(decodeData))
        } catch {
          observer(.failure(NetworkError.decodingFail))
        }
      }.resume()
      return Disposables.create()
    })
  }
  
    
  
}
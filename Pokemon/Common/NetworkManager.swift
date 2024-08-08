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
// 에러가 났을때 네트워크 요청에 시간이 지연이 되었을때 "네트워크 연결 상태를 확인해주세요 "
final class NetworkManager {
  static let shared = NetworkManager()
  
  private init() {}
  //왜 싱글인가에대해서
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

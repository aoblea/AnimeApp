//
//  APIClient.swift
//  AnimeApp
//
//  Created by Arwin Oblea on 5/15/21.
//  Copyright © 2021 iarwinscott. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
  static let sharedInstance = APIClient()
  private lazy var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
  private let animeURL = "https://kitsu.io/api/edge/anime"
  
  typealias AnimeResponseCompletionHandler = (AnimeResponse?, Error?) -> Void
  private func fetchAnimeResponse(using url: String, completionHandler: @escaping AnimeResponseCompletionHandler) {
    AF.request(url)
      .validate()
      .responseDecodable(of: AnimeResponse.self) { (response) in
        
        guard let animes = response.value else { return }
        if let error = response.error {
          completionHandler(nil, error)
          return
        }
        
        completionHandler(animes, nil)
      }
  }
  
  func fetchAnimes(completionHandler: @escaping AnimeResponseCompletionHandler) {
    fetchAnimeResponse(using: animeURL, completionHandler: completionHandler)
  }
  
  func loadImage(using anime: Anime, completionHandler: @escaping (UIImage?) -> Void) {
    print("loading image")
    if let poster = anime.attributes.posterImage {

      AF.request(poster.medium)
        .validate()
        .responseData { (response) in
          if let data = response.data, let image = UIImage(data: data) {
            completionHandler(image)
          } else {
            completionHandler(nil)
          }
        }
  
    } else {
      completionHandler(nil)
    }
  }
  
}

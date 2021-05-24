//
//  Anime.swift
//  AnimeApp
//
//  Created by Arwin Oblea on 5/20/21.
//  Copyright © 2021 iarwinscott. All rights reserved.
//

import UIKit

class Anime: Decodable {
  let id: String
  let type: String
  let attributes: Attribute
  
  var image: UIImage?
  var imageState: ImageDownloadState = .placeholder
  
  enum ImageDownloadState {
    case placeholder
    case downloading
    case finished
    case failed
  }
  
  private enum AnimeCodingKeys: String, CodingKey {
    case id, type, attributes
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: AnimeCodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    type = try container.decode(String.self, forKey: .type)
    attributes = try container.decode(Attribute.self, forKey: .attributes)
  }
  
  struct Attribute: Decodable {
    let description: String?
    let titles: [String: String?]?
    let posterImage: PosterImageURLS?
    let coverImage: CoverImageURLS?
    
    struct PosterImageURLS: Decodable {
      let tiny: String
      let small: String
      let medium: String
      let large: String
      let original: String
    }

    struct CoverImageURLS: Decodable {
      let tiny: String
      let small: String
      let large: String
      let original: String
    }
  }
}

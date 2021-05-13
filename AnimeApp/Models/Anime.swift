//
//  Anime.swift
//  AnimeApp
//
//  Created by Arwin Oblea on 5/13/21.
//  Copyright © 2021 iarwinscott. All rights reserved.
//

import Foundation

struct Anime: Decodable {
  let id: String
  let links: String
  let attributes: String
  let relationships: String
  
  enum AnimeCodingKeys: String, CodingKey {
    case id
    case links
    case attributes
    case relationships
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: AnimeCodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    links = try container.decode(String.self, forKey: .links)
    attributes = try container.decode(String.self, forKey: .attributes)
    relationships = try container.decode(String.self, forKey: .relationships)
  }
}

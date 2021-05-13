//
//  Animes.swift
//  AnimeApp
//
//  Created by Arwin Oblea on 5/13/21.
//  Copyright © 2021 iarwinscott. All rights reserved.
//

import Foundation

struct Animes: Decodable {
  let data: [Anime]
  let meta: String
  let links: String
  
  enum AnimesCodingKeys: String, CodingKey {
    case data
    case meta
    case links
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: AnimesCodingKeys.self)
    data = try container.decode([Anime].self, forKey: .data)
    meta = try container.decode(String.self, forKey: .meta)
    links = try container.decode(String.self, forKey: .links)
  }
}

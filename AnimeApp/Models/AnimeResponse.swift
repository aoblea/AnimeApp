//
//  Animes.swift
//  AnimeApp
//
//  Created by Arwin Oblea on 5/13/21.
//  Copyright © 2021 iarwinscott. All rights reserved.
//

import Foundation

struct AnimeResponse: Decodable {
  let data: [Anime]
  let meta: Meta
  let links: Pages
  
  struct Meta: Decodable {
    let count: Int
  }

  struct Pages: Decodable {
    let first: String
    let previous: String?
    let next: String?
    let last: String
  }
}

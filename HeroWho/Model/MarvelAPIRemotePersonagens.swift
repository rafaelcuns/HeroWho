//
//  MarvelAPIRemotePersonagens.swift
//  RCMarvel
//
//  Created by user on 30/08/23.
//

import Foundation

struct Thumbnail: Decodable {
    let path: String
}

struct MarvelAPIRemotePersonagens: Decodable {
    let data: DataResponse
}

struct DataResponse: Decodable {
    let results: [Personagem]
}

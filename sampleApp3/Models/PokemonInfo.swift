//
//  PokemonInfo.swift
//  sampleApp3
//
//  Created by minato on 2022/11/10.
//

import Foundation

struct PokemonInfo: Codable {
    let name: String
    let id: Int?
    let sprites:Images
}

struct Images: Codable {
    let frontImage: String
    let shinyImage: String
    
    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
        case shinyImage = "front_shiny"
    }
}

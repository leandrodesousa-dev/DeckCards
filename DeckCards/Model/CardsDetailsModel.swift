//
//  CardsDetailsModel.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

struct CardsDetailsModel {
    let image: String
    let value: String
    let suit: String
    let code: String
}

extension CardsDetailsModel: Decodable {
    enum CardsDetailsCodingKeys: String, CodingKey {
        case image
        case value
        case suit
        case code
    }
}

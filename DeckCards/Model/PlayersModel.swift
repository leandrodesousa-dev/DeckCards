//
//  PlayersModel.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

struct PlayersModel {
    let remaining: String
    let cards: CardsDetailsModel?
}

extension PlayersModel: Decodable {
    enum PlayersCodingKeys: String, CodingKey {
        case remaining
        case cards
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PlayersCodingKeys.self)
        
        remaining = try container.decode(String.self, forKey: .remaining)
        cards = try container.decode(CardsDetailsModel.self, forKey: .cards)
    }
}

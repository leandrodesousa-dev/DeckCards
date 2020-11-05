//
//  DeckModel.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

struct DeckModel: Decodable {
    let success: Bool
    let deck_id: String
    let remaining: Int
    let shuffled: Bool?
    let cards: [CardsDetailsModel]?
    let piles: PilesModel?
}

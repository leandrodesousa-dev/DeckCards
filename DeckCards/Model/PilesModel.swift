//
//  PilesModel.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

struct PilesModel {
    let player: PlayersModel
}

extension PilesModel: Decodable {
    enum PilesCodingKeys: String, CodingKey {
        case player
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PilesCodingKeys.self)
        
        player = try container.decode(PlayersModel.self, forKey: .player)
    }
}

//
//  APIDeckBuilder.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

enum APIDeckBuilder {
    case suffleTheCards
    case drawACard(deckId: String)
    case reshuffleTheCards(deckId: String)
    case brandNewDeck
    case partialDeck(cards: String)
    case addingToPiles(deckId: String, pileName: String)
    case shufflePiles(deckId: String, pileName: String)
    case listingCardsInPiles(deckId: String, pileName: String)
    case drawingFromPiles(deckId: String, pileName: String?, cards: String?, count: Int?)
}

extension APIDeckBuilder: APIBase {
    var baseURL: URL {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .suffleTheCards:
            return "new/shuffle/"
        case .drawACard(let deckId):
            return "\(deckId)/draw/"
        case .reshuffleTheCards(let deckId):
            return "\(deckId)/shuffle/"
        case .brandNewDeck:
            return "new/"
        case .partialDeck(let cards):
            return "new/shuffle/?cards=\(cards)"
        case .addingToPiles(let deckId, let pileName):
            return "\(deckId)/pile/\(pileName)/add/?cards=AS,2S"
        case .shufflePiles(let deckId, let pileName):
            return "\(deckId)/pile/\(pileName)/shuffle/"
        case .listingCardsInPiles(let deckId, let pileName):
            return "\(deckId)/pile/\(pileName)/list/"
        case .drawingFromPiles(let deckId, let pileName, let cards, let count):
            guard let pileName = pileName else { return "\(deckId)/draw/bottom/" }
            if let cards = cards {
                return "\(deckId)/pile/\(pileName)/draw/?cards=\(cards)"
            } else if let count = count {
                return "\(deckId)/pile/\(pileName)/draw/?count=\(count)"
            }
        }
        return ""
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .suffleTheCards, .brandNewDeck, .drawACard, .reshuffleTheCards, .partialDeck, .addingToPiles, .shufflePiles,
             .listingCardsInPiles, .drawingFromPiles:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .suffleTheCards, .brandNewDeck:
            return .requestParameters(urlParameters: ["deck_count": 1])
        case .drawACard:
            return .requestParameters(urlParameters: ["count": 11])
        case .reshuffleTheCards(let deckId):
            return .requestParameters(bodyParameters: [:], urlParameters: ["deck_id": deckId])
        case .partialDeck(let cards):
            return .requestParameters(bodyParameters: [:], urlParameters: ["cards": cards])
        case .addingToPiles(let deckId, let pileName):
            return .requestParameters(bodyParameters: [:], urlParameters: ["deck_id": deckId, "pile_name": pileName])
        case .shufflePiles(let deckId, let pileName):
            return .requestParameters(bodyParameters: [:], urlParameters: ["deck_id": deckId, "pile_name": pileName])
        case .listingCardsInPiles(let deckId, let pileName):
            return .requestParameters(bodyParameters: [:], urlParameters: ["deck_id": deckId, "pile_name": pileName])
        case .drawingFromPiles(let deckId, let pileName, let cards, let count):
            return .requestParameters(bodyParameters: [:], urlParameters: ["deck_id": deckId, "pile_name": pileName ?? "",
                                                                           "cards": cards ?? "", "count": count ?? ""])
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-type": "application/json"]
    }
}


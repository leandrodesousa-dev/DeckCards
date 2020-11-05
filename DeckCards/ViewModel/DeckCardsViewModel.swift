//
//  DeckCardsViewModel.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 04/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

class DeckCardsViewModel {
    
    private var cards: [TypeCell] = []
    
    var numberOfCards: Int {
        return cards.count
    }
    
    var cardsSemVazio: [TypeCell] {
        return cards
    }
    
    func addCards() {
        cards.append(.cards(name: "um"))
        cards.append(.cards(name: "dois"))
        cards.append(.cards(name: "tres"))
        cards.append(.cards(name: "quatro"))
        cards.append(.rotationCard(name: "um"))
    }
}

enum TypeCell {
    case cards(name: String)
    case rotationCard(name: String)
}

//
//  DeckCardsViewModel.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 04/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

protocol DeckCardsViewModelCoordinatorDelegate: AnyObject {
    func goToCardInfoScreen(_ viewModel: DeckCardsViewModel)
}

class DeckCardsViewModel {
    
    private var cards: [TypeCell] = []
    
    weak var coordinatorDelegate: DeckCardsViewModelCoordinatorDelegate?
    
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
    
    func goToCardInfoScreen() {
        //coordinatorDelegate?.goToCardInfoScreen(self)
        print("Pegou")
    }
}

enum TypeCell {
    case cards(name: String)
    case rotationCard(name: String)
}

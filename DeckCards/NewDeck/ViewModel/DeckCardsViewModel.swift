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
    private var cardsSegundo: [TypeCellSegundo] = []
    var service: DeckService
    var model: DeckModel
    
    init() {
        let service = DeckService()
        let model = DeckModel(success: false, deck_id: "", remaining: 0, shuffled: nil, cards: nil, piles: nil)
        self.model = model
        self.service = service
    }
    
    weak var coordinatorDelegate: DeckCardsViewModelCoordinatorDelegate?
    
    var numberOfCards: Int {
        cards.count
    }
    
    var numberOfCardsSegundo: Int {
        cardsSegundo.count
    }
    
    var cardsSemVazio: [TypeCell] {
        cards
    }
    
    var cardsSemVazioSegundo: [TypeCellSegundo] {
        cardsSegundo
    }
    
    func testService() {
        service.shuffleTheCards { (result) in
            switch result {
            case .success(let model):
                self.model = model
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func testServiceDraw() {
        service.drawCards(deckId: "ntth3mtn42l6") { (result) in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func addCards() {
        cards.append(.cards(name: "um"))
        cards.append(.cards(name: "dois"))
        cards.append(.cards(name: "tres"))
        cards.append(.cards(name: "quatro"))
        cards.append(.rotationCard(name: "um"))
    }
    
    func addCardsSegundo() {
        cardsSegundo.append(.cards(name: "um"))
        cardsSegundo.append(.cards(name: "dois"))
        cardsSegundo.append(.cards(name: "tres"))
        cardsSegundo.append(.cards(name: "quatro"))
        cardsSegundo.append(.highestValue(name: "um"))
        cardsSegundo.append(.combinations(name: "dois"))
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

enum TypeCellSegundo {
    case cards(name: String)
    case highestValue(name: String)
    case combinations(name: String)
}

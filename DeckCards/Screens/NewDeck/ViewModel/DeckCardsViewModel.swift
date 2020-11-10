//
//  DeckCardsViewModel.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 04/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

// MARK: - Delegates
protocol DeckCardsViewModelCoordinatorDelegate: AnyObject {
    func goToCardInfoScreen(_ viewModel: DeckCardsViewModel, deckId: String)
}

protocol DeckCardsViewModelViewDelegate: AnyObject {
    func cardsSuccess(_ viewModel: DeckCardsViewModel)
    func cardsFailure(_ viewModel: DeckCardsViewModel, error: Error)
}

class DeckCardsViewModel {
    
    // MARK: - Properties 
    var service: DeckService
    var model: DeckModel
    
    // MARK: - Delegates Properties
    weak var coordinatorDelegate: DeckCardsViewModelCoordinatorDelegate?
    weak var viewDelegate: DeckCardsViewModelViewDelegate?
    
    // MARK: - Initializers
    init() {
        let service = DeckService()
        let model = DeckModel(success: false, deck_id: "", remaining: 0, shuffled: nil, cards: nil, piles: nil)
        self.model = model
        self.service = service
    }
    
    // MARK: - Computer Variables Methods
    var cards: [String] {
        guard let cards = model.cards else { return [] }
        return cards.map { $0.image }
    }
    
    var numberOfCards: Int {
        (cards.count + 1) / 2
    }
    
    // MARK: - Methods
    func isTheLastCard(_ index: Int) -> Bool {
        numberOfCards == index + 1
    }
    
    // MARK: - Service Methods
    func brandNewDeck(_ dispatchSemaphore: DispatchSemaphore) {
        dispatchSemaphore.wait()
        service.shuffleTheCards { (result) in
            switch result {
            case .success(let model):
                self.model = model
                self.viewDelegate?.cardsSuccess(self)
            case .failure(let error):
                self.viewDelegate?.cardsFailure(self, error: error)
            }
            dispatchSemaphore.signal()
        }
    }
    
    func drawACard(_ dispatchSemaphore: DispatchSemaphore) {
        dispatchSemaphore.wait()
        service.drawCards(deckId: model.deck_id) { (result) in
            switch result {
            case .success(let model):
                self.model = model
                self.viewDelegate?.cardsSuccess(self)
            case .failure(let error):
                self.viewDelegate?.cardsFailure(self, error: error)
            }
            dispatchSemaphore.signal()
        }
    }
    
    func fetchDeckCards() {
        let semaphore = DispatchSemaphore(value: 1)
        
        brandNewDeck(semaphore)
        drawACard(semaphore)
    }
    
    // MARK: - Coordinator Delegates Methods
    func goToCardInfoScreen() {
        coordinatorDelegate?.goToCardInfoScreen(self, deckId: model.deck_id)
    }
}

//
//  DeckInfoViewModel.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 10/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

// MARK: - Delegates
protocol DeckInfoViewModelViewDelegate: AnyObject {
    func cardsSuccess(_ viewModel: DeckInfoViewModel)
    func cardsFailure(_ viewModel: DeckInfoViewModel, error: Error)
}

class DeckInfoViewModel {
    
    // MARK: - Private Properties
    var cardsCombinationsImages: [String] = []
    
    // MARK: - Private Properties
    private var deckId: String
    private var model: DeckModel
    private var service: DeckService
    private var cardDetailsType: [CardDetailsType] = []
    
    // MARK: - Delegates Properties
    weak var viewDelegate: DeckInfoViewModelViewDelegate?
    
    // MARK: - Initializers
    init(_ deckId: String) {
        self.deckId = deckId
        self.service = DeckService()
        self.model = DeckModel(success: false, deck_id: "", remaining: 0, shuffled: nil, cards: nil, piles: nil)
    }
    
    // MARK: - Service Methods
    func drawACard() {
        service.drawCards(deckId: deckId, count: 6) { (result) in
            switch result {
            case .success(let model):
                self.model = model
                self.implementDetailsCard() 
                self.viewDelegate?.cardsSuccess(self)
            case .failure(let error):
                self.viewDelegate?.cardsFailure(self, error: error)
            }
        }
    }

    // MARK: - Methods
    func cardsInOrder() -> [String] {
        var orderedCards: [CardDetailsType] = []
        
        cardDetailsType.sort { $0.suitOrder < $1.suitOrder }

        cardDetailsType.forEach({ card in
            if card.suitOrder < 4 {
                orderedCards = cardDetailsType.sorted { $0.cardOrder > $1.cardOrder }.sorted {  $0.suitOrder < $1.suitOrder }
            }
        })
        
        return orderedCards.map { $0.image }
    }
    
    func fullHouseCombinations() {
         cardDetailsType.sort { $0.cardOrder < $1.cardOrder }
         var combinationOk = false
         for index in 0..<cardDetailsType.count {
             for _ in 0..<5 {
                 if index < 2 && cardDetailsType[index].value == cardDetailsType[index + 1].value {
                     cardsCombinationsImages.append(cardDetailsType[index].image)
                     if index == 1 {
                         cardsCombinationsImages.append(cardDetailsType[index + 1].image)
                     }
                     combinationOk = true
                 } else if index < 2 && cardDetailsType[index].value != cardDetailsType[index + 1].value  {
                     cardsCombinationsImages = []
                 } else {
                     if combinationOk == true {
                         if (index > 2 && index < 4) && cardDetailsType[index].value == cardDetailsType[index + 1].value {
                             cardsCombinationsImages.append(cardDetailsType[index].image)
                             if index == 3 {
                                 cardsCombinationsImages.append(cardDetailsType[index + 1].image)
                             }
                             
                             combinationOk = true
                         }
                         
                     }
                 }
             }
         }
     }
    
    // MARK: - Private Methods
    func implementDetailsCard() {
        let valueSuit = SuitsDeckModel(rawValue: model.cards?[5].suit ?? "")
        let highestValueSuit = valueSuit ?? SuitsDeckModel.heart
        model.cards?.forEach({ (card) in
            cardDetailsType.append(CardDetailsType(image: card.image, value: card.value,
                                                   suitOrder: SuitsDeckModel(rawValue:
                                                    card.suit)?.convertValue(highestValueSuit: highestValueSuit) ?? 0,
                                                   cardOrder: ValuesDeckModel(rawValue: card.value)?.convertValue() ?? 0))
        })
    }
}

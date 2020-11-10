//
//  DeckService.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

class DeckService: NetworkManager<APIDeckBuilder> {
    func shuffleTheCards(_ completion: @escaping (Swift.Result<DeckModel, Error>) -> Void) {
        fetch(.suffleTheCards) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func drawCards(deckId: String, _ completion: @escaping (Swift.Result<DeckModel, Error>) -> Void) {
        fetch(.drawACard(deckId: deckId)) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func brandNewDeck(_ completion: @escaping (Swift.Result<DeckModel, Error>) -> Void) {
        fetch(.brandNewDeck) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func aPartialDeck(cards: String,_ completion: @escaping (Swift.Result<DeckModel, Error>) -> Void) {
        fetch(.partialDeck(cards: cards)) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

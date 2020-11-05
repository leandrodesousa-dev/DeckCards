//
//  DeckCardsCoordinator.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

class DeckCardsCoordinator {
    
    init() {
        let viewModel = DeckCardsViewModel()
        viewModel.coordinatorDelegate = self
        
    }
}

extension DeckCardsCoordinator: DeckCardsViewModelCoordinatorDelegate {
    func goToCardInfoScreen(_ viewModel: DeckCardsViewModel) {
        //code
    }
}

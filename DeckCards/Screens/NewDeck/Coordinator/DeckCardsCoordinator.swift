//
//  DeckCardsCoordinator.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation
import UIKit

class DeckCardsCoordinator: BaseCoordinator {
    
    // MARK: - Heritage Properties
    typealias View = DeckCardsViewController
    var view: View?
    var navigation: UINavigationController?
    var presentationType: PresentationType?
    
    // MARK: - Child Coordinator
    var deckInfoCoordinator: DeckInfoCoordinator?
    
    // MARK: - Heritage Methods
    func start() -> UINavigationController {
        let viewModel = DeckCardsViewModel()
        viewModel.coordinatorDelegate = self
        
        view = DeckCardsViewController(viewModel)
        guard let view = self.view else { return UINavigationController() }
        
        navigation = UINavigationController(rootViewController: view)
        guard let navigation = self.navigation else { return UINavigationController() }
        
        return navigation
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
        deckInfoCoordinator = nil
    }
}

// MARK: - DeckCardsViewModelCoordinatorDelegate
extension DeckCardsCoordinator: DeckCardsViewModelCoordinatorDelegate {
    func goToCardInfoScreen(_ viewModel: DeckCardsViewModel, deckId: String) {
        guard let navigation = navigation else { return }
        deckInfoCoordinator = DeckInfoCoordinator(deckId)
        deckInfoCoordinator?.start(usingPresentation: .push(navigationController: navigation))
    }
}

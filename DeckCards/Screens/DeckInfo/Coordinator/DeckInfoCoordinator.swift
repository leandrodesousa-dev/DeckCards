//
//  DeckInfoCoordinator.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 08/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation
import UIKit

class DeckInfoCoordinator: BaseCoordinator {
    
    // MARK: - Heritage Properties
    typealias View = DeckInfoViewController
    var view: View?
    var navigation: UINavigationController?
    var presentationType: PresentationType?
    
    // MARK: - Initializers
    init(_ deckId: String) {
        let viewModel = DeckInfoViewModel(deckId)
        let view = DeckInfoViewController(viewModel)
        self.view = view
    }
    
    // MARK: - Heritage Methods
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
}

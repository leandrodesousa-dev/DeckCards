//
//  AppCoordinator.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 08/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    var window: UIWindow
    var deckCardsCoordinator:  DeckCardsCoordinator?
    
    required init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        deckCardsCoordinator = DeckCardsCoordinator()
        self.window.rootViewController = deckCardsCoordinator?.start()
    }
}

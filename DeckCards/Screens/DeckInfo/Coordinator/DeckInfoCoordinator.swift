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
    typealias View = DeckInfoViewController
    var view: View?
    var navigation: UINavigationController?
    var presentationType: PresentationType?
    
    init(_ deckId: String) {
        let view = DeckInfoViewController(.init(deckId))
        self.view = view
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
}

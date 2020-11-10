//
//  BaseCoordinator.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 08/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation
import UIKit

enum PresentationType {
    case push(navigationController: UINavigationController)
    
    func associatedValue() -> Any? {
        switch self {
        case .push(let value):
            return value
        }
    }
}

protocol BaseCoordinator: AnyObject {
    
    associatedtype View: UIViewController
    
    var view: View? { get set }
    
    var navigation: UINavigationController? { get set }
    
    var presentationType: PresentationType? { get set }
    
    func start() -> View
    
    func start(usingPresentation presentation: PresentationType, animated: Bool)
    
    func stop()
}

extension BaseCoordinator {

    func start() -> View {
        if view == nil {
            fatalError("Erro")
        }
        return self.view!
    }
    
    func start(usingPresentation presentation: PresentationType, animated: Bool = true) {
        presentationType = presentation
        switch presentationType {
        case .push(let navigation):
            self.navigation = navigation
            navigation.pushViewController(start(), animated: animated)
        case .none:
            break
        }
        
    }
}

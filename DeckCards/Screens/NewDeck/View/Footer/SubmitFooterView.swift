//
//  SubmitFooterView.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 04/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation
import UIKit

class SubmitFooterView: UITableViewHeaderFooterView {
    
    var onActionSubmitButton: (() -> Void)?
    var onActionShuffleButton: (() -> Void)?
    
    @IBAction func submitButton(_ sender: Any) {
        onActionSubmitButton?()
    }
    
    @IBAction func shuffleButton(_ sender: Any) {
        onActionShuffleButton?()
    }
}

//
//  CombinationsViewCell.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit

class CombinationsViewCell: UITableViewCell {

    @IBOutlet var cardsImageView: [UIImageView]!
    
    func setup() {
        cardsImageView.forEach { (image) in
            image.image = UIImage(named: "card")
        }
    }
}

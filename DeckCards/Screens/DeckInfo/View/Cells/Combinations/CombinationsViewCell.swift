//
//  CombinationsViewCell.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit

class CombinationsViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet var cardsImageView: [UIImageView]!
    
    // MARK: - Methods
    func setup(_ images: [String]) {
        cardsImageView.forEach { (image) in
            images.forEach { (imageCard) in
                image.sd_setImage(with: URL(string: imageCard))
            }
        }
    }
}

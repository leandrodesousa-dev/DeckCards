//
//  HighestValueViewCell.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit

class HighestValueViewCell: UITableViewCell {

    @IBOutlet weak var cardImageView: UIImageView!
    
    func setup() {
        cardImageView.image = UIImage(named: "card")
        cardImageView.contentMode = .top
    }
}

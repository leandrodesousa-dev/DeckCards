//
//  CardsViewCell.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 04/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit

class CardsViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var cardsStackView: UIStackView!
    
    // MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        cardsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    func addCards(_ firstImageName: String, _ lastImageName: String?) {
        let cardView = CardsView()
        cardView.setup(frame: CardsViewCell().frame,
                       firstImageName: firstImageName,
                       lastImageName: lastImageName)
        cardsStackView.addArrangedSubview(cardView)
       
        self.layoutIfNeeded()
    }
}

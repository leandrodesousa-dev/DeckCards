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
    @IBOutlet weak var cardsView: UIStackView!
    
    // MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        cardsView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    func addCards() {
        cardsView.addArrangedSubview(CardsView(frame: CardsViewCell().frame,
                                               firstImage: UIImage(named: "card")!,
                                               lastImage: UIImage(named: "card")!))
        self.layoutIfNeeded()
    }
}

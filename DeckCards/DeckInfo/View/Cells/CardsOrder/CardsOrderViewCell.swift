//
//  CardsOrderViewCell.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit

class CardsOrderViewCell: UITableViewCell {

    @IBOutlet weak var cardsStackView: UIStackView!
    
    // MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        cardsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    func addCards() {
//        cardsStackView.addArrangedSubview(CardsView(frame: CardsViewCell().frame,
//                                               firstImage: UIImage(named: "card")!,
//                                               lastImage: UIImage(named: "card")!))
        self.layoutIfNeeded()
    }
}

//
//  RotationCardViewCell.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 04/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit

class RotationCardViewCell: UITableViewCell {

    @IBOutlet weak var rotationCardStackView: UIStackView!
    
    // MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        rotationCardStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    func addCards() {
        rotationCardStackView.addArrangedSubview(CardsView(frame: CardsViewCell().frame,
                                                           firstImage: UIImage(named: "card")!, rotationCard: true))
        self.layoutIfNeeded()
    }
}

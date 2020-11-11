//
//  HighestValueViewCell.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit
import SDWebImage

class HighestValueViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var cardImageView: UIImageView!
    
    // MARK: - Methods
    func setup(_ image: String?) {
        cardImageView.sd_setImage(with: URL(string: image ?? ""))
        cardImageView.contentMode = .top
    }
}

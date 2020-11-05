//
//  CardsView.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 04/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit

class CardsView: UIView {
    
    // MARK: - Properties
    private let nibName = "CardsView"

    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var firstCardImageView: UIImageView!
    @IBOutlet weak var lastCardImageView: UIImageView!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    init(frame: CGRect, firstImage: UIImage?, lastImage: UIImage? = nil, rotationCard: Bool = false) {
        super.init(frame: frame)
        commonInit()
        firstCardImageView.image = firstImage
        lastCardImageView.image = lastImage
        firstCardImageView.contentMode = .top
        lastCardImageView.contentMode = .top
        lastCardImageView.isHidden = rotationCard
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func commonInit() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

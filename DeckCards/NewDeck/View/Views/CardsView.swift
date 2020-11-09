//
//  CardsView.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 04/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    // MARK: - Methods
    
    func setup(frame: CGRect, firstImageName: String, lastImageName: String?) {
        commonInit()
        DispatchQueue.main.async {
            self.firstCardImageView.sd_setImage(with: URL(string: firstImageName))
            if let lastImageName = lastImageName {
                 self.lastCardImageView.sd_setImage(with: URL(string: lastImageName))
            } else {
                self.lastCardImageView.isHidden = true
            }
        }
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

//
//  DeckCardsViewController.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 04/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit

class DeckCardsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: DeckCardsViewModel!
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Initializers
    init(_ viewModel: DeckCardsViewModel) {
        super.init(nibName: nil,bundle: nil)
        self.viewModel = viewModel
        viewModel.viewDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.fetchDeckCards()
        }
        
        title = "Deck Cards"
        setupTableView()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CardsViewCell", bundle: nil), forCellReuseIdentifier: "CardsViewCell")
        tableView.register(UINib(nibName: "RotationCardViewCell", bundle: nil), forCellReuseIdentifier: "RotationCardViewCell")
        tableView.register(UINib(nibName: "SubmitFooterView", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: "SubmitFooterView")
    }
}

// MARK: - UITableViewDelegate
extension DeckCardsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        50
    }
}

// MARK: - UITableViewDataSource
extension DeckCardsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SubmitFooterView")
            as? SubmitFooterView else { return UIView() }
        
        footerView.onActionButton = {
            self.viewModel.goToCardInfoScreen()
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCards
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cards = viewModel.cards
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsViewCell", for: indexPath) as! CardsViewCell
        cell.addCards(cards[indexPath.row],
                      viewModel.isTheLastCard(indexPath.row) ? nil : cards[indexPath.row + 3])
        return cell
    }
}

//MARK: - DeckCardsViewModelViewDelegate
extension DeckCardsViewController: DeckCardsViewModelViewDelegate {
    func cardsSuccess(_ viewModel: DeckCardsViewModel) {
        print("Success")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func cardsFailure(_ viewModel: DeckCardsViewModel, error: Error) {
        print("Failure")
    }
}

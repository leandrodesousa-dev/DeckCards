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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backgroundView: UIView!
    
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
        
        title = "Deck Cards"
        
        fechtServices()
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
    
    private func setupAlertView() {
        let alert = UIAlertController(title: "Bem vindo!!",
                                      message: "Escolha uma mão com cinco cartas e uma carta de rotação",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func fechtServices() {
        self.startIndicator(false)
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.fetchDeckCards()
        }
    }
    
    private func startIndicator(_ isHidden: Bool) {
        DispatchQueue.main.async {
            !isHidden ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = isHidden
            self.backgroundView.isHidden = isHidden
        }
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
        viewModel.numberLinesOfCards
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cards = viewModel.cards
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsViewCell", for: indexPath) as! CardsViewCell
        let index = indexPath.row * 2
        if !(viewModel.isTheLastCard(index)) {
                    cell.addCards(cards[index], cards[index + 1])
        } else {
           cell.addCards(cards[index], nil)
        }
        return cell
    }
}

//MARK: - DeckCardsViewModelViewDelegate
extension DeckCardsViewController: DeckCardsViewModelViewDelegate {
    func cardsSuccess(_ viewModel: DeckCardsViewModel) {
        print("Success")
        startIndicator(true)
        DispatchQueue.main.async {
            self.setupTableView()
            self.tableView.reloadData()
            self.setupAlertView()
        }
    }
    
    func cardsFailure(_ viewModel: DeckCardsViewModel, error: Error) {
        print("Failure")
    }
}

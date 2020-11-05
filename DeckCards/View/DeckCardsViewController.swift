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
    
    init() {
        super.init(nibName: nil,bundle: nil)
        let viewModel = DeckCardsViewModel()
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Deck Cards"
        setupTableView()
    }
    
    // MARK: - Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CardsViewCell", bundle: nil), forCellReuseIdentifier: "CardsViewCell")
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
        100
    }
}

// MARK: - UITableViewDataSource
extension DeckCardsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SubmitFooterView")
            as? SubmitFooterView else { return UIView() }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCards
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsViewCell", for: indexPath) as! CardsViewCell
        cell.addCards()
        return cell
    }
}

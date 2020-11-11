//
//  DeckInfoViewController.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit

class DeckInfoViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: DeckInfoViewModel!
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Initializers
    init(_ viewModel: DeckInfoViewModel) {
        super.init(nibName: nil,bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Here is the order"
        
        fechtServices()
        viewModel.viewDelegate = self
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CardsOrderViewCell", bundle: nil), forCellReuseIdentifier: "CardsOrderViewCell")
        tableView.register(UINib(nibName: "HighestValueViewCell", bundle: nil), forCellReuseIdentifier: "HighestValueViewCell")
        tableView.register(UINib(nibName: "CombinationsViewCell", bundle: nil), forCellReuseIdentifier: "CombinationsViewCell")
    }
    
    private func fechtServices() {
        self.startIndicator(false)
        DispatchQueue.main.async {
            self.viewModel.drawACard()
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
extension DeckInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension DeckInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row * 2
        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardsOrderViewCell", for: indexPath)
                as! CardsOrderViewCell
            cell.addCards(viewModel.cardsInOrder()[index], viewModel.cardsInOrder()[index + 1])
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HighestValueViewCell", for: indexPath) as! HighestValueViewCell
            cell.setup(viewModel.cardsInOrder().first ?? "")
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CombinationsViewCell", for: indexPath) as! CombinationsViewCell
            viewModel.fullHouseCombinations()
            cell.setup(viewModel.cardsCombinationsImages)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - DeckInfoViewModelViewDelegate
extension DeckInfoViewController: DeckInfoViewModelViewDelegate {
    func cardsSuccess(_ viewModel: DeckInfoViewModel) {
        print("Success")
        startIndicator(true)
        DispatchQueue.main.async {
            self.setupTableView()
            self.tableView.reloadData()
        }
    }
    
    func cardsFailure(_ viewModel: DeckInfoViewModel, error: Error) {
        print("Failure")
    }
}

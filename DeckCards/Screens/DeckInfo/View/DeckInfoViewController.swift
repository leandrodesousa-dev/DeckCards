//
//  DeckInfoViewController.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import UIKit

class DeckInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: DeckInfoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Here is the order"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CardsOrderViewCell", bundle: nil), forCellReuseIdentifier: "CardsOrderViewCell")
        tableView.register(UINib(nibName: "HighestValueViewCell", bundle: nil), forCellReuseIdentifier: "HighestValueViewCell")
        tableView.register(UINib(nibName: "CombinationsViewCell", bundle: nil), forCellReuseIdentifier: "CombinationsViewCell")
        
        //viewModel.drawACard()
        print("Deck Id Info: ", viewModel.getDeckId())
    }
    
    init(_ viewModel: DeckInfoViewModel) {
        super.init(nibName: nil,bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DeckInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension DeckInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
//        let cards = viewModel.cardsSemVazioSegundo[indexPath.row]
//        switch cards {
//        case .cards:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CardsOrderViewCell", for: indexPath) as! CardsOrderViewCell
//            cell.addCards()
//            return cell
//        case .combinations:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HighestValueViewCell", for: indexPath) as! HighestValueViewCell
//            cell.setup()
//            return cell
//        case .highestValue:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CombinationsViewCell", for: indexPath) as! CombinationsViewCell
//            cell.setup()
//            return cell
//        }
    }
}

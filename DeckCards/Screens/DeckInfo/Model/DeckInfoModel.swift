//
//  DeckInfoModel.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 09/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

// MARK: - CardDetailsType
struct CardDetailsType {
    var image: String
    var value: String
    var suitOrder: Int
    var cardOrder: Int
}

// MARK: - SuitsDeckModel
enum SuitsDeckModel: String {
    case heart = "HEARTS"
    case diamond = "DIAMONDS"
    case club = "CLUBS"
    case spades = "SPADES"
}

extension SuitsDeckModel {
    func convertValue(highestValueSuit suit: SuitsDeckModel) -> Int {
        switch self {
        case .heart:
            switch suit {
            case .heart:
                return 1
            case .diamond:
                return 2
            case .club:
                return 3
            case .spades:
                return 4
            }
        case .diamond:
            switch suit {
            case .heart:
                return 4
            case .diamond:
                return 1
            case .club:
                return 2
            case .spades:
                return 3
            }
        case .club:
            switch suit {
            case .heart:
                return 3
            case .diamond:
                return 4
            case .club:
                return 1
            case .spades:
                return 2
            }
        case .spades:
            switch suit {
            case .heart:
                return 2
            case .diamond:
                return 3
            case .club:
                return 4
            case .spades:
                return 1
            }
        }
    }
}

// MARK: - ValuesDeckModel
enum ValuesDeckModel: String {
    case two = "2"
    case ace = "ACE"
    case king = "KING"
    case queen = "QUEEN"
    case jack = "JACK"
    case ten = "10"
    case nine = "9"
    case eight = "8"
    case seven = "7"
    case six = "6"
    case five = "5"
    case four = "4"
    case three = "3"
}

extension ValuesDeckModel {
    func convertValue() -> Int {
        switch self {
        case .two: return 1
        case .ace: return 2
        case .king: return 3
        case .queen: return 4
        case .jack: return 5
        case .ten: return 6
        case .nine: return 7
        case .eight: return 8
        case .seven: return 9
        case .six: return 10
        case .five: return 11
        case .four: return 12
        case .three: return 13
        }
    }
}

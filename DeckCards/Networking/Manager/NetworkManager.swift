//
//  NetworkManager.swift
//  DeckCards
//
//  Created by Leandro de Sousa on 05/11/20.
//  Copyright © 2020 Leandro de Sousa. All rights reserved.
//

import Foundation

enum NetworkResponse: String, Error {
    case success
    case authenticationError = "You need to be autheticated first."
    case badResquest = "Bad resquest"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

class NetworkManager<T: APIBase> {
    private var provider = NetworkProvider<T>()
    
    func fetch(_ route: T, completion: @escaping (Swift.Result<DeckModel, Error>) -> Void) {
        provider.request(route) { (data, response, error) in
            if error != nil {
                completion(.failure(NetworkError.errorProvider))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NetworkError.errorResponse))
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(DeckModel.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkError.errorResponse))
                    }
                case .failure(let errorResponse):
                    completion(.failure(NetworkResponse(rawValue: errorResponse) ?? NetworkError.errorResponse))
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badResquest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

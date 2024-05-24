//
//  CurrencyListProvider.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation
import Combine

protocol CurrencyListProviderProtocol {
    
    func requestCurrencyList<R: NetworkRequest>(request: R) -> AnyPublisher<CurrencyListResponse,NetworkingError>
    
}

class CurrencyListProvider {
    
    var networkManager : NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
}

extension CurrencyListProvider: CurrencyListProviderProtocol {

    internal func requestCurrencyList<R>(request: R) -> AnyPublisher<CurrencyListResponse, NetworkingError> where R:NetworkRequest {
        
        return self.networkManager.requestGeneric(request: request, entity: CurrencyListResponse.self)
            .map { response in
                return Just(response)
                .setFailureType(to: NetworkingError.self)
                .eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }

}

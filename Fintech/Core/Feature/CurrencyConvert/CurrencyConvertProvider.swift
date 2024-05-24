//
//  CurrencyConvertProvider.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation
import Combine

protocol CurrencyConvertProviderProtocol {
    
    func requestCurrencyConvert<R: NetworkRequest>(request: R) -> AnyPublisher<CurrencyConvertResponse,NetworkingError>
    
}

class CurrencyConvertProvider {
    
    var networkManager : NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
}

extension CurrencyConvertProvider: CurrencyConvertProviderProtocol {

    internal func requestCurrencyConvert<R>(request: R) -> AnyPublisher<CurrencyConvertResponse, NetworkingError> where R:NetworkRequest {
        
        return self.networkManager.requestGeneric(request: request, entity: CurrencyConvertResponse.self)
            .map { response in
                return Just(response)
                .setFailureType(to: NetworkingError.self)
                .eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }

}

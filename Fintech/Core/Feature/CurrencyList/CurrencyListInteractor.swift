//
//  CurrencyListInteractor.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation
import Combine

protocol CurrencyListInteractorInputProtocol: BaseInteractorInputProtocol {
    
    func requestCurrencyList()
    
}

class CurrencyListInteractor: BaseInteractor {
    
    var cancellable: Set<AnyCancellable> = []
    weak var presenter: CurrencyListInteractorOutputProtocol? {return super.basePresenter as? CurrencyListInteractorOutputProtocol}
    var currencyListProvider: CurrencyListProviderProtocol?
    
}

extension CurrencyListInteractor: CurrencyListInteractorInputProtocol {
    
    func requestCurrencyList() {
        
        let request = CurrencyListRequest(model: CurrencyListModel())
        
        self.currencyListProvider?.requestCurrencyList(request: request)
            .sink {[weak self] completion in
                guard self != nil else { return }
                switch completion {
                case .finished: break
                case .failure(let error):
                    if case let NetworkingError.custom(message) = error {
                        self?.presenter?.error(message: message)
                    } else {
                        self?.presenter?.error(message: error.localizedDescription)
                    }
                }
            } receiveValue: { [weak self] response in
                guard self != nil else { return }
                self?.presenter?.success(currencies: response.currencies)
            }.store(in: &self.cancellable)
    }
    
}

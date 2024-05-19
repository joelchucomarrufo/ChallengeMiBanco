//
//  CurrencyConvertInteractor.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation
import Combine

protocol CurrencyConvertInteractorInputProtocol: BaseInteractorInputProtocol {
    
    func requestCurrencyConvert(currencyConvert: CurrencyConvertModel)
    func requestCurrencyRate(currencyConvert: CurrencyConvertModel)
    
}

class CurrencyConvertInteractor: BaseInteractor {
    
    var cancellable: Set<AnyCancellable> = []
    weak var presenter: CurrencyConvertInteractorOutputProtocol? {return super.basePresenter as? CurrencyConvertInteractorOutputProtocol}
    var currencyConvertProvider: CurrencyConvertProviderProtocol?
    
}

extension CurrencyConvertInteractor: CurrencyConvertInteractorInputProtocol {
    
    func requestCurrencyConvert(currencyConvert: CurrencyConvertModel) {
        
        let request = CurrencyConvertRequest(model: currencyConvert)
        
        self.currencyConvertProvider?.requestCurrencyConvert(request: request)
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
                self?.presenter?.success(convert: response)
            }.store(in: &self.cancellable)
    }
    
    func requestCurrencyRate(currencyConvert: CurrencyConvertModel) {
        
        let request = CurrencyConvertRequest(model: currencyConvert)
        
        self.currencyConvertProvider?.requestCurrencyConvert(request: request)
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
                response.rates.keys.forEach { key in
                    self?.presenter?.success(rate: response.rates[key]?.rate ?? "")
                }
            }.store(in: &self.cancellable)
    }
}

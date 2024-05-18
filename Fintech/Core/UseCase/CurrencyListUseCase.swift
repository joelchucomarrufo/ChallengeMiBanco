//
//  CurrencyListUseCase.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

public protocol CurrencyListUseCaseDelegate: AnyObject {
    
    func eventSuccess(currencies: [String: String])
    
    func eventError(message: String)
    
}

public class CurrencyListUseCase {

    var presenter: CurrencyListPresenterProtocol
    public weak var eventDelegate: CurrencyListUseCaseDelegate?
   
    public init() {
        self.presenter = CurrencyListCoordinator.build()
        self.presenter.delegate = self
    }
    
    init(presenter: CurrencyListPresenterProtocol) {
        self.presenter = presenter
        self.presenter.delegate = self
    }
    
    public func requestCurrencyList() {
        presenter.requestCurrencyList()
    }
    
}


extension CurrencyListUseCase: CurrencyListPresenterDelegate {
    
    func error(message: String) {
        eventDelegate?.eventError(message: message)
    }
    
    func success(currencies: [String: String]) {
        eventDelegate?.eventSuccess(currencies: currencies)
    }
}

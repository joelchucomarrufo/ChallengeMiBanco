//
//  CurrencyListPresenter.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation
protocol CurrencyListPresenterProtocol {    
    func requestCurrencyList()
    var delegate: CurrencyListPresenterDelegate? { get set }
}

protocol CurrencyListPresenterDelegate {
    func success(currencies: [String: String])
    func error(message: String)
}

protocol CurrencyListInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func success(currencies: [String: String])
    func error(message: String)
    
}

class CurrencyListPresenter: BasePresenter {
    var currencyListModel: CurrencyListModel?
    var interactor: CurrencyListInteractorInputProtocol? { return super.baseInteractor as? CurrencyListInteractorInputProtocol}
    var delegate: CurrencyListPresenterDelegate?
}

extension CurrencyListPresenter: CurrencyListPresenterProtocol {
  
    internal func requestCurrencyList() {
        interactor?.requestCurrencyList()
    }
}

extension CurrencyListPresenter: CurrencyListInteractorOutputProtocol {
    
    func error(message: String) {
        delegate?.error(message: message)
    }
    
    func success(currencies: [String: String]) {
        delegate?.success(currencies: currencies)
    }
}

//
//  CurrencyConvertPresenter.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

protocol CurrencyConvertPresenterProtocol {
    
    func requestCurrencyConvert(convertModel: ConvertModel)
    func requestCurrencyRate(convertModel: ConvertModel)
    var delegate: CurrencyConvertPresenterDelegate? { get set }
}

protocol CurrencyConvertPresenterDelegate {
    func success(convert: CurrencyConvertResponse)
    func success(rate: String)
    func error(message: String)
}

protocol CurrencyConvertInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func success(convert: CurrencyConvertResponse)
    func success(rate: String)
    func error(message: String)
    
}

class CurrencyConvertPresenter: BasePresenter {
    var currencyConvertModel: CurrencyConvertModel?
    var interactor: CurrencyConvertInteractorInputProtocol? { return super.baseInteractor as? CurrencyConvertInteractorInputProtocol}
    var delegate: CurrencyConvertPresenterDelegate?
}

extension CurrencyConvertPresenter: CurrencyConvertPresenterProtocol {
    
    internal func requestCurrencyConvert(convertModel: ConvertModel) {
        currencyConvertModel = CurrencyConvertModel(from: convertModel.from, to: convertModel.to, amount: convertModel.amount)
        if let currencyConvert = currencyConvertModel {
            interactor?.requestCurrencyConvert(currencyConvert: currencyConvert)
        }
    }
    
    internal func requestCurrencyRate(convertModel: ConvertModel) {
        currencyConvertModel = CurrencyConvertModel(from: convertModel.from, to: convertModel.to, amount: convertModel.amount)
        if let currencyConvert = currencyConvertModel {
            interactor?.requestCurrencyRate(currencyConvert: currencyConvert)
        }
    }
}

extension CurrencyConvertPresenter: CurrencyConvertInteractorOutputProtocol {
    
    func error(message: String) {
        delegate?.error(message: message)
    }
    
    func success(convert: CurrencyConvertResponse) {
        delegate?.success(convert: convert)
    }
    
    func success(rate: String) {
        delegate?.success(rate: rate)
    }
}

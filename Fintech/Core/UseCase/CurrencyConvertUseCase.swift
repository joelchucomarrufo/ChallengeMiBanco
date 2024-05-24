//
//  CurrencyConvertUseCase.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

public protocol CurrencyConvertUseCaseDelegate: AnyObject {
    
    func eventSuccess(convert: ConvertResponse)
    
    func eventSuccess(rate: String)
    
    func eventError(message: String)
    
}

public class CurrencyConvertUseCase {

    var presenter: CurrencyConvertPresenterProtocol
    public weak var eventDelegate: CurrencyConvertUseCaseDelegate?
   
    public init() {
        self.presenter = CurrencyConvertCoordinator.build()
        self.presenter.delegate = self
    }
    
    init(presenter: CurrencyConvertPresenterProtocol) {
        self.presenter = presenter
        self.presenter.delegate = self
    }
    
    public func requestCurrencyConvert(convert: ConvertModel) {
        presenter.requestCurrencyConvert(convertModel: convert)
    }
    
    public func requestCurrencyRate(convert: ConvertModel) {
        presenter.requestCurrencyRate(convertModel: convert)
    }
}

extension CurrencyConvertUseCase: CurrencyConvertPresenterDelegate {
    
    func error(message: String) {
        eventDelegate?.eventError(message: message)
    }
    
    func success(convert: CurrencyConvertResponse) {
        var convertResponse = ConvertResponse()
        convert.rates.keys.forEach { key in
            convertResponse = ConvertResponse(
                    baseCurrencyCode: convert.base_currency_code,
                    baseCurrencyName: convert.base_currency_name,
                    amount: convert.amount,
                    currencyName: convert.rates[key]?.currency_name ?? "",
                    rate: convert.rates[key]?.rate ?? "",
                    rateForAmount: convert.rates[key]?.rate_for_amount ?? "")
        }
        eventDelegate?.eventSuccess(convert: convertResponse)
    }
    
    func success(rate: String) {
        eventDelegate?.eventSuccess(rate: rate)
    }
}

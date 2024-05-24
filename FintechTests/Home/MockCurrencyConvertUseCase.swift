//
//  MockCurrencyConvertUseCase.swift
//  FintechTests
//
//  Created by Joel Martin Chuco Marrufo on 19/05/24.
//

import XCTest
@testable import Fintech

class MockCurrencyConvertUseCase: CurrencyConvertUseCase {
    var delegate: CurrencyConvertUseCaseDelegate?
    
    override func requestCurrencyRate(convert: ConvertModel) {
        delegate?.eventSuccess(rate: "3.50")
    }
    
    override func requestCurrencyConvert(convert: ConvertModel) {
        var converResponse = ConvertResponse()
        converResponse.rateForAmount = "350.0"
        delegate?.eventSuccess(convert: converResponse)
    }
}

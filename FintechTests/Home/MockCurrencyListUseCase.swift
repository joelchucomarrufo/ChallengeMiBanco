//
//  MockCurrencyListUseCase.swift
//  FintechTests
//
//  Created by Joel Martin Chuco Marrufo on 19/05/24.
//

import XCTest
@testable import Fintech

class MockCurrencyListUseCase: CurrencyListUseCase {
    var delegate: CurrencyListUseCaseDelegate?
    
    override func requestCurrencyList() {
        delegate?.eventSuccess(currencies: ["USD": "US Dollar", "EUR": "Euro"])
    }
}

//
//  HomeViewModelTests.swift
//  FintechTests
//
//  Created by Joel Martin Chuco Marrufo on 19/05/24.
//

import XCTest
import SwiftData
@testable import Fintech

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockCurrencyListUseCase: MockCurrencyListUseCase!
    var mockCurrencyConvertUseCase: MockCurrencyConvertUseCase!
    var context: ModelContext!
        
    @MainActor 
    override func setUp() {
        super.setUp()
        context = mockContainer.mainContext
        mockCurrencyListUseCase = MockCurrencyListUseCase()
        mockCurrencyConvertUseCase = MockCurrencyConvertUseCase()
        viewModel = HomeViewModel(currencyListUseCase: mockCurrencyListUseCase, currencyConvertUseCase: mockCurrencyConvertUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockCurrencyListUseCase = nil
        mockCurrencyConvertUseCase = nil
        super.tearDown()
    }
    
    func testIsValidFieldSuccess() {
        viewModel.amountHave = "1000"
        XCTAssertTrue(viewModel.isValidField())
    }
    
    func testIsValidFieldFailure() {
        viewModel.amountHave = ""
        XCTAssertFalse(viewModel.isValidField())
    }
    
    func testSaveTransactionSuccess() {
        viewModel.amountSale = "S/ 3.7654"
        viewModel.amountPurchase = "S/ 3.7654"
        viewModel.amountHave = "1000"
        viewModel.currencyHave = "PEN"
        viewModel.currencyYouReceive = "USD"
        viewModel.currencyHave = "PEN"
        viewModel.amountYouReceive = "3765.4"
        viewModel.rateSelect = "3.7654"
        
        viewModel.saveTransaction(context: context)
        
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertFalse(viewModel.isError)
        XCTAssertTrue(viewModel.showMessage)
        XCTAssertEqual(viewModel.message, NSLocalizedString("message-register-transaction", comment: ""))
    }

    func testSaveTransactionFailure() {
        viewModel.amountHave = ""
        
        viewModel.saveTransaction(context: context)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.isError)
        XCTAssertTrue(viewModel.showMessage)
        XCTAssertEqual(viewModel.message, NSLocalizedString("message-validation-enter-amount", comment: ""))
    }
}

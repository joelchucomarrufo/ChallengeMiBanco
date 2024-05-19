//
//  HomeViewModel.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 17/05/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject{
    static let shared = HomeViewModel()
        
    @Published var currencyList: [String: String] = [:]
    
    @Published var amountSale = "S/ 0.00"
    @Published var amountPurchase = "S/ 0.00"
    @Published var amountHave = ""
    @Published var amountYouReceive = ""
    @Published var currencyHave = "PEN"
    @Published var currencyYouReceive = "USD"
    
    @Published var isLoading = false
    @Published var showMessage = false
    @Published var isSuccess = false
    @Published var errorMessage = ""
        
    let currencyListUseCase = CurrencyListUseCase()
    let currencyConvertUseCase = CurrencyConvertUseCase()
        
    init() {
        currencyListUseCase.eventDelegate = self
        currencyConvertUseCase.eventDelegate = self
    }
        
    func requestCurrencyList() {
        isLoading = true
        currencyListUseCase.requestCurrencyList()
        requestCurrencyRate()
        
    }
    
    func requestCurrencyRate() {
        currencyConvertUseCase.requestCurrencyRate(convert: ConvertModel(from: currencyYouReceive, to: currencyHave, amount: 1))
        
    }
    
    func requestCurrencyConvert() {
        isLoading = true
        let amountDecimal = Decimal(string: amountHave.replacingOccurrences(of: ",", with: "")) ?? 0.00
        currencyConvertUseCase.requestCurrencyConvert(convert: ConvertModel(from: currencyHave, to: currencyYouReceive, amount: amountDecimal))
    }
    
}

extension HomeViewModel : CurrencyListUseCaseDelegate{
    
    func eventSuccess(currencies: [String : String]) {
        self.currencyList = currencies
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
        }
    }
        
    func eventError(message: String) {
        self.isLoading = false
        self.errorMessage = message
        self.showMessage = true
    }
}

extension HomeViewModel : CurrencyConvertUseCaseDelegate {
    
    func eventSuccess(convert: ConvertResponse) {
        self.isLoading = false
        amountYouReceive = convert.rateForAmount.formattedAmount()
    }
    
    func eventSuccess(rate: String) {
        self.isLoading = false
        amountSale = "\(currencyHave) \(String(describing: rate))"
        amountPurchase = "\(currencyHave) \(String(describing: rate))"
    }
        
}

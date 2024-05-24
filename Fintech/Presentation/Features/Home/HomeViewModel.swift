//
//  HomeViewModel.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 17/05/24.
//

import Foundation
import SwiftUI
import SwiftData

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
    @Published var isError = false
    @Published var message = ""
    var rateSelect = ""
        
    var currencyListUseCase = CurrencyListUseCase()
    var currencyConvertUseCase = CurrencyConvertUseCase()
        
    init(currencyListUseCase: CurrencyListUseCase = CurrencyListUseCase(), currencyConvertUseCase: CurrencyConvertUseCase = CurrencyConvertUseCase()) {
        self.currencyListUseCase = currencyListUseCase
        self.currencyConvertUseCase = currencyConvertUseCase
        
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
    
    func saveTransaction(context: ModelContext) {
        self.isLoading = true
        if (isValidField()) {
            let newTransaction = Transaction(
                dateTime: Date(),
                haveAmount: amountHave,
                currencyCodeHave: currencyHave,
                youReceiveAmount: amountYouReceive,
                currencyCodeYouReceive: currencyYouReceive,
                rate: rateSelect)
            context.insert(newTransaction)
            
            self.message = NSLocalizedString("message-register-transaction", comment: "")
            self.isError = false
            self.showMessage = true
                             
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.amountSale = "S/ 0.00"
                self.amountPurchase = "S/ 0.00"
                self.amountHave = ""
                self.amountYouReceive = ""
                self.currencyHave = "PEN"
                self.currencyYouReceive = "USD"
                self.requestCurrencyRate()
            }
        } else {
            self.message = NSLocalizedString("message-validation-enter-amount", comment: "")
            self.isError = true
            self.isLoading = false
            self.showMessage = true
        }
        
    }
    
    func isValidField() -> Bool {
        if (!amountHave.isEmpty) {
            let amountDecimal = Decimal(string: amountHave.replacingOccurrences(of: ",", with: "")) ?? 0.00
            return (amountDecimal > 0.00)
        } else {
            return false
        }
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
        self.message = message
        self.isError = true
        self.isLoading = false
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
        self.rateSelect = String(describing: rate)
        amountSale = "\(currencyHave) \(self.rateSelect)"
        amountPurchase = "\(currencyHave) \(self.rateSelect)"
    }
        
}

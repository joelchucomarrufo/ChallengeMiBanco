//
//  ConvertResponse.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

public struct ConvertResponse: Codable {
    
    var baseCurrencyCode: String
    var baseCurrencyName: String
    var amount: String
    var currencyName: String
    var rate: String
    var rateForAmount: String
    
    public init() {
        self.baseCurrencyCode = ""
        self.baseCurrencyName = ""
        self.amount = ""
        self.currencyName = ""
        self.rate = ""
        self.rateForAmount = ""
    }
    
    public init(baseCurrencyCode: String, baseCurrencyName: String, amount: String, currencyName: String, rate: String, rateForAmount: String) {
        self.baseCurrencyCode = baseCurrencyCode
        self.baseCurrencyName = baseCurrencyName
        self.amount = amount
        self.currencyName = currencyName
        self.rate = rate
        self.rateForAmount = rateForAmount
    }
}

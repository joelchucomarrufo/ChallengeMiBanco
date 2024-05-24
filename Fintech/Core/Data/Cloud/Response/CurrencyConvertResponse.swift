//
//  CurrencyConvertResponse.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

struct CurrencyConvertResponse: Codable {
    
    let base_currency_code: String
    let base_currency_name: String
    let amount: String
    let rates: [String:CurrencyConvertRateResponse]
    let status: String
    
}

struct CurrencyConvertRateResponse: Codable {
    
    let currency_name: String
    let rate: String
    let rate_for_amount: String
    
}

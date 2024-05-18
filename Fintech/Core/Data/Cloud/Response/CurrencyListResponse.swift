//
//  CurrencyListResponse.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

struct CurrencyListResponse: Codable {
    
    let currencies: [String: String]
    let status: String
    
}

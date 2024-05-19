//
//  CurrencyConvertModel.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

struct CurrencyConvertModel : Decodable {
    
    var from: String
    var to: String
    var amount: Decimal
    
}

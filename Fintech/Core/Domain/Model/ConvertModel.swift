//
//  ConvertModel.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

public struct ConvertModel {
    let from: String
    let to: String
    let amount: Decimal
    
    public init() {
        self.from = ""
        self.to = ""
        self.amount = 0.00
    }
    
    public init(from: String, to: String, amount: Decimal) {
        self.from = from
        self.to = to
        self.amount = amount
    }
    
}

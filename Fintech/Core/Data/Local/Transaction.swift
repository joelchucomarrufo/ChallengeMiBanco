//
//  Transaction.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 17/05/24.
//

import Foundation
import SwiftData

@Model
final class Transaction {
    
    var id = UUID()
    var dateTime: Date
    var haveAmount: String
    var currencyCodeHave: String
    var youReceiveAmount: String
    var currencyCodeYouReceive: String
    var rate: String
       
    init(dateTime: Date, haveAmount: String, currencyCodeHave: String, youReceiveAmount: String, currencyCodeYouReceive: String, rate: String) {
        self.dateTime = dateTime
        self.haveAmount = haveAmount
        self.currencyCodeHave = currencyCodeHave
        self.youReceiveAmount = youReceiveAmount
        self.currencyCodeYouReceive = currencyCodeYouReceive
        self.rate = rate
    }
        
    func formattedDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, hh:mm a"
        return dateFormatter.string(from: dateTime)
    }
    
}

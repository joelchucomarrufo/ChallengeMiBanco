//
//  CustomExtensions.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 17/05/24.
//

import Foundation
import SwiftUI

extension Text {
    
    func applyStyleDescription() -> some View {
        self.font(.custom("MuseoSans-500", size: 14))
    }
    
    func applyStyleItem() -> some View {
        self.font(.custom("MuseoSans-500", size: 16))
    }
    
    func applyStyleItemBold() -> some View {
        self.font(.custom("Brevia-Semibold", size: 16))
    }
    
}


extension View {
    
    func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

extension String {
    
    func formattedAmount()->String {
        var amountString = self
        amountString = amountString.replacingOccurrences(of: ",", with: "")
        let formatter = NumberFormatter()
        let USLocalCurrency = Locale(identifier: "en_US")
        formatter.locale = USLocalCurrency
        formatter.positiveFormat = "#,##0.00"
        let convertedAmount = formatter.string(from: NSNumber.init(value: Double(amountString) ?? 0.0)) ?? ""
        return convertedAmount
    }
    
}

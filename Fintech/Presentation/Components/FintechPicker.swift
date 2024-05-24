//
//  FintechPicker.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation
import SwiftUI

struct FintechPicker: View {
    
    var title: LocalizedStringKey
    let currencies: [String: String]
    @Binding var showCurrencyPicker: Bool
    @Binding var activeTextField: HomeView.ActiveTextField?
    @Binding var currencyHave: String
    @Binding var currencyYouReceive: String
    var onTapped: () -> Void

    var body: some View {
        VStack {
            Text(title)
                .font(.custom("Brevia-Semibold", size: 16))
                .padding([.top, .bottom], 16)
            
            List(currencies.keys.sorted(), id: \.self) { key in
                HStack {
                    Text(key)
                        .applyStyleItemBold()                    
                        .foregroundStyle(Color("TextSubTitle"))
                        .padding(.trailing, 8)
                    
                    Text(currencies[key] ?? "")
                        .applyStyleItem()
                        .foregroundStyle(Color("TextDescription"))
                    
                    Spacer()
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showCurrencyPicker = false
                        if activeTextField == .currencyHave {
                            currencyHave = key
                        } else if activeTextField == .currencyYouReceive {
                            currencyYouReceive = key
                        }
                        activeTextField = nil
                        onTapped()
                    }
                }
            }
        }
    }
}

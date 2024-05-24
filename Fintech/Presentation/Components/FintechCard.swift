//
//  FintechCard.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 19/05/24.
//

import Foundation
import SwiftUI

struct FintechCard: View {
    let transaction: Transaction
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(transaction.formattedDateTime())
                    .font(.custom("Brevia-Semibold", size: 16))
                    .foregroundStyle(Color("TextTitle"))
                Spacer()
                Text("TC: \(transaction.rate)")
                    .font(.custom("Brevia-Semibold", size: 16))
                    .foregroundStyle(Color("TextSubTitle"))
            }
            .padding(.top, 16)
            
            HStack {
                Text("title-you-sent")
                    .foregroundStyle(Color("TextDescription"))
                    .applyStyleItem()
                Spacer()
                Text("\(transaction.currencyCodeHave) \(transaction.haveAmount)")
                    .foregroundStyle(Color("TextDescription"))
                    .applyStyleItem()
            }
            .padding(.top, 8)
            
            HStack {
                Text("title-you-sent")
                    .foregroundStyle(Color("TextDescription"))
                    .applyStyleItem()
                Spacer()
                Text("\(transaction.currencyCodeYouReceive) \(transaction.youReceiveAmount)")
                    .foregroundStyle(Color("TextDescription"))
                    .applyStyleItem()
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
        .padding([.leading, .trailing], 16)
        .background(Color("TextFieldBackground"))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("BorderTextFocus"), lineWidth: 1)
        )
        .padding([.leading, .trailing], 16)
        .padding(.top, 8)
    }
}

//
//  AlertDialogScreen.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 19/05/24.
//

import Foundation
import SwiftUI

struct AlertDialogScreen: View {
    
    @Binding var isVisible: Bool
    var message: String
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image(systemName: "multiply.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: 48, height: 48)
                    .padding(.top, 24)
                
                Text("Fintech")
                    .font(.custom("Outfit-Bold", size: 22))
                    .foregroundStyle(Color("TextTitle"))
                    .padding(.top, 16)
                
                Text(message)
                    .font(.custom("Outfit-Regular", size: 14))
                    .foregroundStyle(Color("TextDescription"))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.top, 16)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                
                FintechButton(
                    type: .primary,
                    title: "title-button-accept",
                    action: {
                        isVisible = false
                    }
                )
                .padding(24)
            }
            .frame(width: 320)
            .background(Color("Background"))
            .cornerRadius(10)
            .shadow(radius: 10)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    VStack{
        AlertDialogScreen(isVisible: .constant(true), message: NSLocalizedString("title-validation-enter-amount", comment: ""))
    }
}

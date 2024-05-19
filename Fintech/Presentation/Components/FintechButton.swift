//
//  FintechButton.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation
import SwiftUI

struct FintechButton: View {
        
    var type: ButtonType
    var title: LocalizedStringKey
    var action: () -> Void
    
    enum ButtonType {
        case primary, secondary
    }
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.custom("Brevia-Semibold", size: 16))
                .padding()
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: type == .secondary ? 2 : 0)
                )
        }
    }
    
    private var backgroundColor: Color {
        switch type {
        case .primary:
            return Color("BackgroundButtonPrimary")
        case .secondary:
            return Color.clear
        }
    }
    
    private var foregroundColor: Color {
        switch type {
        case .primary:
            return .white
        case .secondary:
            return Color("BackgroundButtonPrimary")
        }
    }
    private var borderColor: Color {
        return Color("BackgroundButtonPrimary")
    }
}

//
//  FintechTextField.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 17/05/24.
//

import Foundation
import SwiftUI

struct FintechTextField: View {
    
    var title: LocalizedStringKey
    var hint: LocalizedStringKey
    var keyboardType : UIKeyboardType = .numberPad
    @FocusState private var isFocused: Bool
    @Binding var text: String
    @Binding var secondText: String
    var onSecondTextTapped: () -> Void
    @Binding var isDisabled: Bool
    var onFinishEditing: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Brevia-Semibold", size: 14))
                .foregroundStyle(Color("TextDescription"))
                .padding(.bottom, 4)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("TextFieldBackground")).padding(2))
                
                HStack {
                    TextField(hint, text: $text, onEditingChanged: { editing in
                        if !editing {
                            DispatchQueue.main.async {
                                text = text.formattedAmount()
                                onFinishEditing()
                            }
                        }
                    })
                    .multilineTextAlignment(.trailing)
                    .keyboardType(keyboardType)
                    .font(.custom("MuseoSans-500", size: 16))
                    .padding([.top, .bottom], 8)
                    .padding([.leading, .trailing], 12)
                    .background(Color.clear)
                    .focused($isFocused)
                    .disabled(isDisabled)
                    .onChange(of: text) { _ in
                        if text.count > 12 {
                            text = String(text.prefix(12))
                        }
                    }
                    
                    Text(secondText)
                        .font(.custom("Brevia-Semibold", size: 16))
                        .foregroundStyle(Color("TextDescription"))
                        .padding(.trailing, 12)
                        .onTapGesture {
                            onSecondTextTapped()
                        }
                }
            }
            .frame(height: 40)
        }
    }
        
    private var borderColor: Color {
        if (isFocused) {
            return Color("BorderTextFocus")
        } else {
            return Color("BorderTextUnfocus")
        }
    }
        
}

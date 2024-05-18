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
    
}


extension View {
    
    func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

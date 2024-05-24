//
//  LoadingScreen.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation
import SwiftUI

struct LoadingScreen: View {
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                LoadingCircleView()
            }
            .frame(width: 96, height: 96)
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

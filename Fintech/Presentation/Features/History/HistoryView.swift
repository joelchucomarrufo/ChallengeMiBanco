//
//  HistoryView.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var transactions: [Transaction]
    
    var body: some View {
        
        VStack {
            
            HStack (alignment: .center) {
                Button(action: {
                    withAnimation {
                        ScreenNavigation().redirectToScreen(to: HomeView().environment(\.modelContext, modelContext), direction: .fromLeft)
                    }
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color("TextDescription"))
                }
                .frame(width: 24, height: 24)
                .padding(.leading, 24)
                
                Spacer()
                
                Text("title-record")
                    .font(.custom("Brevia-Semibold", size: 18))
                    .foregroundStyle(Color("TextSubTitle"))
                    .padding([.top, .bottom], 16)
                
                Spacer()
                
            }
            .frame(height: 48)
               
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(transactions) { transaction in
                        FintechCard(transaction: transaction)
                    }
                }
            }
        }
    }
}

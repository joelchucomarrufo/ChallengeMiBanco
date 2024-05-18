//
//  ContentView.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 17/05/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
        
    @Environment(\.colorScheme) var colorScheme
    @State private var amountSale = "S/ 3.7895"
    @State private var amountPurchase = "S/ 3.7895"
    @State private var amountHave = ""
    @State private var amountYouReceive = ""
    @State private var currencyHave = "Nuevos Sol"
    @State private var currencyYouReceive = "Dólares"
    
    var body: some View {
        
        VStack (alignment: .leading){
            HStack (alignment: .center) {
                Image(colorScheme == .dark ? "LogoWhite" : "Logo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.black)
                    .frame(width: 128)
                
                Spacer()
                
                Text("title-currency-exchange")
                    .font(.custom("Brevia-Semibold", size: 16))
                    .foregroundStyle(Color("TextTitle"))
                    .frame(width: 180)
                
            }
            .padding(.top, 24)
            
            HStack (alignment: .center) {
                Text("title-sale \(amountSale)")
                    .foregroundStyle(Color("TextSubTitle"))
                    .applyStyleDescription()
                
                Spacer()
                
                Text("title-purchase \(amountPurchase)")
                    .foregroundStyle(Color("TextDescription"))
                    .applyStyleDescription()
            }
            .padding(.top, 24)
            
            HStack (alignment: .center) {
                VStack {
                    FintechTextField(
                        title: LocalizedStringKey("title-have"),
                        hint: LocalizedStringKey("hint-amount"),
                        text: $amountHave,
                        secondText: $currencyHave)
                    
                    FintechTextField(
                        title: LocalizedStringKey("title-receive"),
                        hint: LocalizedStringKey("hint-amount"),
                        text: $amountYouReceive,
                        secondText: $currencyYouReceive)
                    .padding(.top, 24)
                }
                
                Spacer()
                
                
                
            }
            .padding(.top, 24)
            
            Spacer()
        }
        .padding([.leading, .trailing], 24)
    }
    
}


#Preview {
    ContentView()
}


/*
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
*/

//
//  ContentView.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 17/05/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {

    @ObservedObject var homeViewModel = HomeViewModel.shared

    @Environment(\.colorScheme) var colorScheme
    @State private var amountSale = "S/ 3.7895"
    @State private var amountPurchase = "S/ 3.7895"
    @State private var amountHave = ""
    @State private var amountYouReceive = ""
    @State private var currencyHave = "Nuevos Sol"
    @State private var currencyYouReceive = "Dólares"

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
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

                HStack(alignment: .center) {
                    Text("title-sale \(amountSale)")
                        .foregroundStyle(Color("TextSubTitle"))
                        .applyStyleDescription()

                    Spacer()

                    Text("title-purchase \(amountPurchase)")
                        .foregroundStyle(Color("TextDescription"))
                        .applyStyleDescription()
                }
                .padding(.top, 24)

                HStack(alignment: .center) {
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

                    Button(action: {

                    }) {
                        Image(systemName: "arrow.up.arrow.down.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 56, height: 56)
                            .padding()
                            .background(Color.clear)
                            .foregroundColor(Color("TextSubTitle"))
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top, 24)

                Button(action: {

                }) {
                    Text("title-button-operation")
                        .font(.custom("Brevia-Semibold", size: 16))
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                        .background(Color("BackgroundButtonPrimary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 24)

                Text("title-record")
                    .font(.custom("Brevia-Semibold", size: 16))
                    .foregroundStyle(Color("TextSubTitle"))
                    .padding(.top, 24)

                Spacer()
            }
            .padding([.leading, .trailing], 24)
            .background(
                Color("Background")
                    .onTapGesture {
                        hideKeyboard()
                    }
            )
            .onAppear {
                homeViewModel.requestCurrencyList()
            }

            if homeViewModel.isLoading {
                LoadingScreen()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    HomeView()
}

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
    @Environment(\.modelContext) private var modelContext
    
    @State private var showCurrencyPicker = false
    @State private var activeTextField: ActiveTextField? = nil

    enum ActiveTextField {
        case currencyHave
        case currencyYouReceive
    }
    
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
                    Text("title-sale \(homeViewModel.amountSale)")
                        .foregroundStyle(Color("TextSubTitle"))
                        .applyStyleDescription()

                    Spacer()

                    Text("title-purchase \(homeViewModel.amountPurchase)")
                        .foregroundStyle(Color("TextDescription"))
                        .applyStyleDescription()
                }
                .padding(.top, 24)

                HStack(alignment: .center) {
                    VStack {
                        FintechTextField(
                            title: LocalizedStringKey("title-have"),
                            hint: LocalizedStringKey("hint-amount"),
                            text: $homeViewModel.amountHave,
                            secondText: $homeViewModel.currencyHave,
                            onSecondTextTapped: {
                                activeTextField = .currencyHave
                                showCurrencyPicker = true
                            },
                            isDisabled: .constant(false),
                            onFinishEditing: {
                                homeViewModel.requestCurrencyConvert()
                            })

                        FintechTextField(
                            title: LocalizedStringKey("title-receive"),
                            hint: LocalizedStringKey("hint-amount"),
                            text: $homeViewModel.amountYouReceive,
                            secondText: $homeViewModel.currencyYouReceive,
                            onSecondTextTapped: {
                                activeTextField = .currencyYouReceive
                                showCurrencyPicker = true
                            },
                            isDisabled: .constant(true),
                            onFinishEditing: {
                            })
                        .padding(.top, 24)
                    }

                    Button(action: {
                        let codeTemp = homeViewModel.currencyYouReceive
                        homeViewModel.currencyYouReceive = homeViewModel.currencyHave
                        homeViewModel.currencyHave = codeTemp
                        homeViewModel.requestCurrencyRate()
                        homeViewModel.requestCurrencyConvert()
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
                
                Spacer()
                
                FintechButton(
                    type: .primary,
                    title: LocalizedStringKey("title-button-operation"),
                    action: {
                        hideKeyboard()
                        homeViewModel.saveTransaction(context: modelContext)
                    }
                )
                .padding(.top, 48)
                
                FintechButton(
                    type: .secondary,
                    title: LocalizedStringKey("title-record"),
                    action: {
                        hideKeyboard()
                        ScreenNavigation().redirectToScreen(to: HistoryView().environment(\.modelContext, modelContext), direction: .fromRight)
                    }
                )
                .padding(.top, 16)
                .padding(.bottom, 48)
                
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
            
            if showCurrencyPicker {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        FintechPicker(
                            title: LocalizedStringKey("title-picker-currency"),
                            currencies: homeViewModel.currencyList,
                            showCurrencyPicker: $showCurrencyPicker,
                            activeTextField: $activeTextField,
                            currencyHave: $homeViewModel.currencyHave,
                            currencyYouReceive: $homeViewModel.currencyYouReceive,
                            onTapped: {
                                homeViewModel.requestCurrencyRate()
                                homeViewModel.requestCurrencyConvert()
                            }
                        )
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.8)
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: showCurrencyPicker)
                    }
                    .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showCurrencyPicker = false
                        }
                    }
                }
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

//
//  HomeViewModel.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 17/05/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject{
    static let shared = HomeViewModel()
        
    @Published var isLoading = false
    @Published var showMessage = false
    @Published var isSuccess = false
    @Published var errorMessage = ""
        
    let currencyListUseCase = CurrencyListUseCase()
        
    init() {
        currencyListUseCase.eventDelegate = self
    }
        
    func requestCurrencyList() {
        isLoading = true
        currencyListUseCase.requestCurrencyList()
    }
    
}

extension HomeViewModel: CurrencyListUseCaseDelegate{
    func eventSuccess(currencies: [String : String]) {
        print(currencies)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
        }
    }
        
    func eventError(message: String) {
        self.isLoading = false
        self.errorMessage = message
        self.showMessage = true
    }
}

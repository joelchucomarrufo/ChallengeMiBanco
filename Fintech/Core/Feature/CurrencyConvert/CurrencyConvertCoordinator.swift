//
//  CurrencyConvertCoordinator.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

final class CurrencyConvertCoordinator: BaseCoordinator {
    
    static func build() -> CurrencyConvertPresenter {
        let vip = BaseCoordinator.assemblyPresenter(presenter: CurrencyConvertPresenter.self, interactor: CurrencyConvertInteractor.self)
        vip.interactor.currencyConvertProvider = CurrencyConvertProvider()
        return vip.presenter
    }
    
}

//
//  CurrencyListCoordinator.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

final class CurrencyListCoordinator: BaseCoordinator {
    
    static func build() -> CurrencyListPresenter {
        let vip = BaseCoordinator.assemblyPresenter(presenter: CurrencyListPresenter.self, interactor: CurrencyListInteractor.self)
        vip.interactor.currencyListProvider = CurrencyListProvider()
        return vip.presenter
    }
    
}

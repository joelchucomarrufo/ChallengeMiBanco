//
//  Base.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

protocol BaseInteractorInputProtocol: AnyObject {}
protocol BaseInteractorOutputProtocol: AnyObject {}

class BasePresenter {
    internal var baseInteractor: BaseInteractorInputProtocol?
    required init() {}
}

class BaseInteractor {
    internal var basePresenter: BaseInteractorOutputProtocol?
    required init() {}
}

class BaseCoordinator {
    
    static func assemblyPresenter<Presenter: BasePresenter, Interactor: BaseInteractor>(presenter: Presenter.Type, interactor: Interactor.Type) -> (presenter: Presenter, interactor: Interactor) {
        let basePresenter = Presenter()
        let baseInteractor = Interactor()
        basePresenter.baseInteractor = baseInteractor as? BaseInteractorInputProtocol
        baseInteractor.basePresenter = basePresenter as? BaseInteractorOutputProtocol
        return (basePresenter, baseInteractor)
    }
    
}

//
//  AdListRouter.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//
import UIKit
// MARK: - Protocols
@MainActor
protocol AdListRouterProtocol: AnyObject {
    static func createAdListModule() -> UIViewController
}


// MARK: - Class
@MainActor
final class AdListRouter: AdListRouterProtocol {
    
    static func createAdListModule() -> UIViewController {
        // Initializing VIPER module variables
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "adListId") as? AdListViewController else { return AdListViewController() }
        let presenter: AdListPresenterProtocol & AdListInteractorOutputProtocol = AdListPresenter()
        var interactor: AdListInteractorInputProtocol & AdListLocalDataManagerOutputProtocol = AdsListInteractor()
        let localDataManager: AdListLocalDataManagerProtocol = AdListLocalDataManager()
        let router: AdListRouterProtocol = AdListRouter()
        // Assigning VIPER module variables
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDataManager = localDataManager
        return view
    }
}


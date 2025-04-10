//
//  AdListRouter.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//
import UIKit
import SwiftUI
// MARK: - Protocols
@MainActor
protocol AdListRouterProtocol: AnyObject {
    static func createAdListModule() -> UIViewController
    func goToDetailAd(currentViewController: AdListViewControllerProtocol?, ad: Ad)
    func goToMapView(currentViewController: AdListViewControllerProtocol?, ad: [Ad])
}


// MARK: - Class
@MainActor
final class AdListRouter: AdListRouterProtocol {
    
    static func createAdListModule() -> UIViewController {
        // Initializing VIPER module variables
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "adListId") as? AdListViewController else { return AdListViewController() }
        let presenter: AdListPresenterProtocol & AdListInteractorOutputProtocol = AdListPresenter()
        var interactor: AdListInteractorInputProtocol & AdListLocalDataManagerOutputProtocol = AdListInteractor()
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
    
    func goToDetailAd(currentViewController: AdListViewControllerProtocol?, ad: Ad) {
        guard let viewController = currentViewController as? UIViewController,
              let navigationController = viewController.navigationController else { return }
        let detailPageViewController = UIHostingController(rootView: DetailAdPage(viewModel: DetailAdPageViewModel(ad: ad)))
        navigationController.pushViewController(detailPageViewController, animated: true)
    }
    
    func goToMapView(currentViewController: AdListViewControllerProtocol?, ad: [Ad]) {
        guard let viewController = currentViewController as? UIViewController,
              let navigationController = viewController.navigationController else { return }
        let mapViewController = UIHostingController(rootView: MapView(ads: ad))
        navigationController.pushViewController(mapViewController, animated: true)
    }
}


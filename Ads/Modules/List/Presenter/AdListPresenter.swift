//
//  AdListPresenter.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//
import Foundation
// MARK: - Protocols
protocol AdListPresenterProtocol: AnyObject {
    var view: AdListViewControllerProtocol? { get set }
    var interactor: AdListInteractorInputProtocol? { get set }
    var router: AdListRouterProtocol? { get set }
    
    @MainActor func viewDidLoad()
    @MainActor func getAllAds()
    @MainActor func favoriteAdAction(_ ad: Ad)
}

protocol AdListInteractorOutputProtocol: AnyObject {
    func showFetchedAds(list: [Ad])
    func favoriteAdSaved(with propertyCode: String, date: Date?)
    func favoriteAdRemoved(with propertyCode: String)
    func showAlertError()
}


// MARK: - Class
final class AdListPresenter  {
    
    // Protocol vars
    weak var view: AdListViewControllerProtocol?
    var interactor: AdListInteractorInputProtocol?
    var router: AdListRouterProtocol?
    
    // Private vars
    private var adsList: [Ad] = []
    
    // Private functions
    private func updateFavoriteAd(with propertyCode: String, isFavorite: Bool, date: Date?) {
        guard let index = adsList.firstIndex(where: { $0.propertyCode == propertyCode }), let view else { return }
        adsList[index].isFavorite = isFavorite
        view.setFavoriteAd(with: index, of: adsList, date: isFavorite ? date : nil)
    }
}

extension AdListPresenter: AdListPresenterProtocol {
    
    @MainActor
    func viewDidLoad() {
        guard let view = self.view else { return }
        view.loadUI()
        self.getAllAds()
    }
    
    @MainActor
    func getAllAds() {
        guard let interactor = self.interactor else { return }
        interactor.getAllAds()
    }
    
    @MainActor
    func favoriteAdAction(_ ad: Ad) {
        guard let interactor else { return }
        interactor.setFavouriteAd(ad)
    }
}


extension AdListPresenter: AdListInteractorOutputProtocol {
    
    func favoriteAdSaved(with propertyCode: String, date: Date?) {
        self.updateFavoriteAd(with: propertyCode, isFavorite: true, date: date)
    }

    func favoriteAdRemoved(with propertyCode: String) {
        self.updateFavoriteAd(with: propertyCode, isFavorite: false, date: nil)
    }
    
    func showAlertError() {
        guard let view else { return }
        view.showAlertError()
    }
    
    func showFetchedAds(list: [Ad]) {
        guard let view else { return }
        self.adsList = list
        view.fetchedAds(list: list)
    }

}

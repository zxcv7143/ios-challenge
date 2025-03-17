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
    @MainActor func goToDetailAd(with ad: Ad)
    @MainActor func showAdLocationsOnMap(ads: [Ad])
}

protocol AdListInteractorOutputProtocol: AnyObject {
    func showFetchedAds(list: [Ad])
    func favoriteAdSaved(ad: FavouriteAd)
    func favoriteAdRemoved(with propertyCode: String)
    
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
        adsList[index].isFavourite = isFavorite
        adsList[index].dateSavedAsFavorite = date
        view.setFavoriteAd(with: index, of: adsList)
    }
}

extension AdListPresenter: AdListPresenterProtocol {
    func goToDetailAd(with ad: Ad) {
        guard let router else { return }
        router.goToDetailAd(currentViewController: view, ad: ad)
    }
    
    
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
    
    @MainActor func showAdLocationsOnMap(ads: [Ad]) {
        guard let view, let router else { return }
        router.goToMapView(currentViewController: view, ad: ads)
    }
}


extension AdListPresenter: AdListInteractorOutputProtocol {
    
    func favoriteAdSaved(ad: FavouriteAd) {
        self.updateFavoriteAd(with: ad.propertyCode ?? "0", isFavorite: true, date: ad.savingDate)
    }

    func favoriteAdRemoved(with propertyCode: String) {
        self.updateFavoriteAd(with: propertyCode, isFavorite: false, date: nil)
    }
    
    func showFetchedAds(list: [Ad]) {
        guard let view else { return }
        self.adsList = list
        view.fetchedAds(list: list)
    }

}

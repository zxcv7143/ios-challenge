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
    
    @MainActor func viewDidLoad() async
    @MainActor func getAllAds() async
    @MainActor func goToDetailAd(with ad: Ad)
    @MainActor func showAdLocationsOnMap(ads: [Ad])
    @MainActor func favouriteAdAction(_ ad: Ad)
}

protocol AdListInteractorOutputProtocol: AnyObject {
    func showFetchedAds(list: [Ad])
    func favouriteAdSaved(ad: FavouriteAd)
    func favouriteAdRemoved(with propertyCode: String)
    
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
    private func updateFavouriteAd(with propertyCode: String, isFavourite: Bool, date: Date?) {
        guard let index = adsList.firstIndex(where: { $0.propertyCode == propertyCode }) else { return }
        adsList[index].isFavourite = isFavourite
        adsList[index].dateSavedAsFavourite = date
        view?.setFavouriteAd(with: index, of: adsList)
    }
}

extension AdListPresenter: AdListPresenterProtocol {
    func goToDetailAd(with ad: Ad) {
        router?.goToDetailAd(currentViewController: view, ad: ad)
    }
    
    
    @MainActor
    func viewDidLoad() async {
        view?.loadUI()
        await self.getAllAds()
    }
    
    
    func getAllAds() async {
        await interactor?.getAllAds()
    }
    

    @MainActor func favouriteAdAction(_ ad: Ad) {
        interactor?.setFavouriteAd(ad)
    }
    
    @MainActor func showAdLocationsOnMap(ads: [Ad]) {
        guard let view else { return }
        router?.goToMapView(currentViewController: view, ad: ads)
    }
}


extension AdListPresenter: AdListInteractorOutputProtocol {
    
    func favouriteAdSaved(ad: FavouriteAd) {
        self.updateFavouriteAd(with: ad.propertyCode ?? "0", isFavourite: true, date: ad.savingDate)
    }

    func favouriteAdRemoved(with propertyCode: String) {
        self.updateFavouriteAd(with: propertyCode, isFavourite: false, date: nil)
    }
    
    func showFetchedAds(list: [Ad]) {
        self.adsList = list
        view?.fetchedAds(list: list)
    }

}

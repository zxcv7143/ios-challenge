//
//  AdListInteractor.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//
import Foundation

// MARK: - Protocols
protocol AdListInteractorInputProtocol {
    var localDataManager: AdListLocalDataManagerProtocol? { get set }
    var presenter: AdListInteractorOutputProtocol? { get set }
    @MainActor func getAllAds() async
    @MainActor func setFavouriteAd(_ ad: Ad)
}

protocol AdListLocalDataManagerOutputProtocol: AnyObject {
    func favouriteAdSaved(ad: FavouriteAd)
    func favouriteAdRemoved(with propertyCode: String)
}

// MARK: - Class
final class AdListInteractor: AdListInteractorInputProtocol {
    
    // Protocols vars
    weak var presenter: AdListInteractorOutputProtocol?
    var localDataManager: AdListLocalDataManagerProtocol?
    
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol = NetworkClient()) {
        self.httpClient = httpClient
    }
    
    // Protocol functions
    @MainActor
    func getAllAds() async {
        guard let url = URL(string: Urls.AdList.adList), let localDataManager else {
            return
        }
        let result = await httpClient.performRequest(url: url, responseType: [AdDTO].self)
        
        switch result {
        case .success(let ads):
            guard let presenter = self.presenter else { return }
            var adList = ads.map { Ad(dto: $0) }
            adList = adList.map { ad in
                var mutableAd = ad
                mutableAd.isFavourite = localDataManager.isFavouriteAd(propertyCode: ad.propertyCode)
                mutableAd.dateSavedAsFavourite = localDataManager.fetchFavouriteAdSavingDate(by: ad.propertyCode)
                return mutableAd
            }
            presenter.showFetchedAds(list: adList)
        case .failure: break
        }
    }
    @MainActor
    func setFavouriteAd(_ ad: Ad) {
        guard let localDataManager else { return }
        if ad.isFavourite {
            localDataManager.removeFavouriteAd(propertyCode: ad.propertyCode) { [weak self] removed in
                guard let self else { return }
                if removed {
                    favouriteAdRemoved(with: ad.propertyCode)
                }
            }
        } else {
            localDataManager.saveFavouriteAd(propertyCode: ad.propertyCode) { [weak self] saved, savedAd in
                guard let self, let savedAd else { return }
                if saved {
                    favouriteAdSaved(ad: savedAd)
                }
            }
        }
    }
}

// Protocol: LocalDataManager -> Interactor
extension AdListInteractor: AdListLocalDataManagerOutputProtocol {
    
    func favouriteAdSaved(ad: FavouriteAd) {
        guard let presenter else { return }
        presenter.favouriteAdSaved(ad: ad)
    }
    
    func favouriteAdRemoved(with propertyCode: String) {
        guard let presenter else { return }
        presenter.favouriteAdRemoved(with: propertyCode)
    }
}


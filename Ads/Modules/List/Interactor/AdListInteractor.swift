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
    @MainActor func getAllAds()
    @MainActor func setFavouriteAd(_ ad: Ad)
}

protocol AdListLocalDataManagerOutputProtocol: AnyObject {
    func favouriteAdSaved(with propertyCode: String, date: Date?)
    func favouriteAdRemoved(with propertyCode: String)
    func showAlertError()
}

// MARK: - Class
final class AdsListInteractor: AdListInteractorInputProtocol {
    
    // Protocols vars
    weak var presenter: AdListInteractorOutputProtocol?
    var localDataManager: AdListLocalDataManagerProtocol?
    
    private let httpClient: HTTPClientProtocol = NetworkClient()
    
    // Protocol functions
    @MainActor
    func getAllAds() {
        guard let url = URL(string: Urls.AdList.adList), let localDataManager, let presenter else {
            return
        }
        httpClient.performRequest(url: url, responseType: [AdDTO].self) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let ads):
                    guard let presenter = self.presenter else { return }
                    var adList = ads.map { Ad(dto: $0) }
                    adList = adList.map { ad in
                        var mutableAd = ad
                        mutableAd.isFavorite = localDataManager.isFavouriteAd(propertyCode: ad.propertyCode)
                        mutableAd.dateSavedAsFavorite = localDataManager.fetchFavouriteAdSavingDate(by: ad.propertyCode)
                        return mutableAd
                    }
                    presenter.showFetchedAds(list: adList)
                case .failure:
                    presenter.showAlertError()
            }
        }
    }
    @MainActor
    func setFavouriteAd(_ ad: Ad) {
        guard let localDataManager else { return }
        if ad.isFavorite {
            localDataManager.removeFavouriteAd(propertyCode: ad.propertyCode) { [weak self] removed in
                guard let self else { return }
                removed ? favouriteAdRemoved(with: ad.propertyCode) : showAlertError()
            }
        } else {
            localDataManager.saveFavouriteAd(propertyCode: ad.propertyCode) { [weak self] saved, savingDate in
                guard let self else { return }
                saved ? favouriteAdSaved(with: ad.propertyCode, date: savingDate) : showAlertError()
            }
        }
    }
}

// Protocol: LocalDataManager -> Interactor
extension AdsListInteractor: AdListLocalDataManagerOutputProtocol {
    
    func favouriteAdSaved(with propertyCode: String, date: Date?) {
        guard let presenter else { return }
        presenter.favoriteAdSaved(with: propertyCode, date: date)
    }
    
    func favouriteAdRemoved(with propertyCode: String) {
        guard let presenter else { return }
        presenter.favoriteAdRemoved(with: propertyCode)
    }
    
    func showAlertError() {
        guard let presenter else { return }
        presenter.showAlertError()
    }
}


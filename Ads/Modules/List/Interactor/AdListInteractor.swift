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
    func getAllAds() async
    func setFavouriteAd(_ ad: Ad)
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
    
    private let repository: AdRepositoryProtocol
    
    init(repository: AdRepositoryProtocol = AdRepository()) {
        self.repository = repository
    }
    
    // Protocol functions
    func getAllAds() async {
        guard let localDataManager, let presenter, var adList = try? await repository.getAdList()  else {
            return
        }
        adList = adList.map { ad in
            var mutableAd = ad
            mutableAd.isFavourite = localDataManager.isFavouriteAd(propertyCode: ad.propertyCode)
            mutableAd.dateSavedAsFavourite = localDataManager.fetchFavouriteAdSavingDate(by: ad.propertyCode)
            return mutableAd
        }
        presenter.showFetchedAds(list: adList)
    }
        
    func setFavouriteAd(_ ad: Ad)  {
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
        presenter?.favouriteAdSaved(ad: ad)
    }
    
    func favouriteAdRemoved(with propertyCode: String) {
        presenter?.favouriteAdRemoved(with: propertyCode)
    }
}


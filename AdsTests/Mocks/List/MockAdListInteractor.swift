//
//  MockAdListInteractor.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//

@testable import Ads

class MockAdListInteractor: AdListInteractorInputProtocol {
    var localDataManager: (any Ads.AdListLocalDataManagerProtocol)?
    var presenter: (any Ads.AdListInteractorOutputProtocol)?
    
    var getAllAdsCalled = false
    var setFavouriteAdCalled = false
    var favouriteAd: Ad?
    
    func getAllAds() {
        getAllAdsCalled = true
    }
    
    func setFavouriteAd(_ ad: Ad) {
        setFavouriteAdCalled = true
        favouriteAd = ad
    }
    
    
}

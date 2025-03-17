//
//  Untitled.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
@testable import Ads
import Foundation

class MockAdListLocalDataManager: AdListLocalDataManagerProtocol {
    
    var isFavouriteAdCalled = false
    var saveFavouriteAdCalled = false
    var removeFavouriteAddCalled = false
    var fetchAllFavouriteAdsCalled = false
    var fetchFavouriteAdSavingDateCalled = false
    
    func isFavouriteAd(propertyCode: String) -> Bool {
        isFavouriteAdCalled = true
        return true
    }
    
    func saveFavouriteAd(propertyCode: String, completion: (Bool, Ads.FavouriteAd?) -> (Void)) {
        saveFavouriteAdCalled = true
    }
    
    func removeFavouriteAd(propertyCode: String, removed completion: (Bool) -> (Void)) {
        removeFavouriteAddCalled = true
    }
    
    func fetchAllFavouriteAds() {
        fetchAllFavouriteAdsCalled = true
    }
    
    func fetchFavouriteAdSavingDate(by propertyCode: String) -> Date? {
        fetchFavouriteAdSavingDateCalled = true
        return Date()
    }
    
}


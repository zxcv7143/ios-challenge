//
//  MockAdListViewController.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//

@testable import Ads

class MockAdListViewController: AdListViewControllerProtocol {
    var presenter: (any Ads.AdListPresenterProtocol)?
    
    var loadUICalled = false
    var fetchedAdsCalled = false
    var setFavouriteAdCalled = false
    var adList: [Ad]?
    
    func loadUI() {
        loadUICalled = true
    }
    
    func fetchedAds(list: [Ad]) {
        fetchedAdsCalled = true
        adList = list
    }
    
    func setFavoriteAd(with index: Int, of ads: [Ad]) {
        setFavouriteAdCalled = false
    }
    
}

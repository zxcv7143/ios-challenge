//
//  AdListInteractorTests.swift
//  AdsTests
//
//  Created by Anton Zuev on 17/3/25.
//

import Testing
@testable import Ads

struct AdListInteractorTests {
    
    
    @Test("Test getting all ads") @MainActor func testGetAllAds() async  {
        let interactor = AdListInteractor(httpClient: MockNetworkClient(response: mockAds))
        let presenter = MockAdListPresenter()
        interactor.presenter = presenter
        interactor.localDataManager = MockAdListLocalDataManager()
        await interactor.getAllAds()
        #expect(presenter.calledShowFetchedAds == true)
        #expect(presenter.showedAds.count == mockAds.count)
    }
    
    @Test("Test removing favourite ad") @MainActor
    func testRemovingFavouriteAd() {
        let interactor = AdListInteractor(httpClient: MockNetworkClient(response: mockAds))
        let presenter = MockAdListPresenter()
        let localDataManager = MockAdListLocalDataManager()
        interactor.presenter = presenter
        interactor.localDataManager = localDataManager
        var ad = Ad(dto: mockAds.first!)
        ad.isFavourite = true
        interactor.setFavouriteAd(ad)
        #expect(localDataManager.removeFavouriteAddCalled == true)
    }
    
    @Test("Test adding favourite ad") @MainActor
    func testAddingFavouriteAd() {
        let interactor = AdListInteractor(httpClient: MockNetworkClient(response: mockAds))
        let presenter = MockAdListPresenter()
        let localDataManager = MockAdListLocalDataManager()
        interactor.presenter = presenter
        interactor.localDataManager = localDataManager
        var ad = Ad(dto: mockAds.first!)
        ad.isFavourite = false
        interactor.setFavouriteAd(ad)
        #expect(localDataManager.saveFavouriteAdCalled == true)
    }

}

//
//  AdsListPresenterTests.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//

import Testing
@testable import Ads

struct AdListPresenterTests {
    
    @Test("Test getting all ads") @MainActor
    func testGetAllAds() async throws {
        let presenter = AdListPresenter()
        let interactor = MockAdListInteractor()
        let viewController = MockAdListViewController()
        let router = MockAdListRouter()
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.getAllAds()
        #expect(interactor.getAllAdsCalled)
    }
    
    @Test("Test getting all ads at first load") @MainActor
    func testGetAllAdsAtFirstLoad() async throws {
        let presenter = AdListPresenter()
        let interactor = MockAdListInteractor()
        let viewController = MockAdListViewController()
        let router = MockAdListRouter()
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.viewDidLoad()
        #expect(interactor.getAllAdsCalled)
    }
    
    @Test("Test going to detail ad page") @MainActor
    func testGoToDetailPage() async throws {
        let presenter = AdListPresenter()
        let interactor = MockAdListInteractor()
        let viewController = MockAdListViewController()
        let router = MockAdListRouter()
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        let ad = mockAds.first!
        presenter.goToDetailAd(with: Ad(dto: ad))
        #expect(router.goToDetailAdCalled)
    }
    
    @Test("Test going to detatil ad page") @MainActor
    func testFavouriteAdAction() async throws {
        let presenter = AdListPresenter()
        let interactor = MockAdListInteractor()
        let viewController = MockAdListViewController()
        let router = MockAdListRouter()
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        let ad = mockAds.first!
        presenter.favoriteAdAction(Ad(dto: ad))
        #expect(interactor.setFavouriteAdCalled)
    }
    
    @Test("Test show ad location on map") @MainActor
    func testShowLocationsOnMap() async throws {
        let presenter = AdListPresenter()
        let interactor = MockAdListInteractor()
        let viewController = MockAdListViewController()
        let router = MockAdListRouter()
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        let ad = mockAds.first!
        presenter.showAdLocationsOnMap(ads: [Ad(dto: ad)])
        #expect(router.goToMapViewCalled)
    }
}

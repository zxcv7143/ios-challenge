//
//  MockAdListPresenter.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
@testable import Ads

class MockAdListPresenter: AdListPresenterProtocol,  AdListInteractorOutputProtocol  {
    
    var calledViewDidLoad = false
    var calledGetAllAds = false
    var calledFavoriteAdAction = false
    var calledGoToDetailAd = false
    var calledShowAdLocationsOnMap = false
    var calledShowFetchedAds = false
    var calledFavoriteAdSaved = false
    var calledFavoriteAdRemoved = false
    var showedAds: [Ad] = []
    
    
    var view: (any AdListViewControllerProtocol)?
    
    var interactor: (any AdListInteractorInputProtocol)?
    
    var router: (any AdListRouterProtocol)?
    
    func viewDidLoad() {
        self.calledViewDidLoad = true
    }
    
    func getAllAds() {
        self.calledGetAllAds = true
    }
    
    func favoriteAdAction(_ ad: Ad) {
        self.calledFavoriteAdAction = true
    }
    
    func goToDetailAd(with ad: Ad) {
        self.calledGoToDetailAd = true
    }
    
    func showAdLocationsOnMap(ads: [Ad]) {
        self.calledShowAdLocationsOnMap = true
    }
    
    func showFetchedAds(list: [Ad]) {
        self.calledShowFetchedAds = true
        self.showedAds = list
    }
    
    func favoriteAdSaved(ad: FavouriteAd) {
        self.calledFavoriteAdSaved = true
    }
    
    func favoriteAdRemoved(with propertyCode: String) {
        self.calledFavoriteAdRemoved = true
    }
}
    

    


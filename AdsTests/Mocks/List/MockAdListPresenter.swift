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
    var calledFavouriteAdAction = false
    var calledGoToDetailAd = false
    var calledShowAdLocationsOnMap = false
    var calledShowFetchedAds = false
    var calledFavouriteAdSaved = false
    var calledFavouriteAdRemoved = false
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
    
    func favouriteAdAction(_ ad: Ad) {
        self.calledFavouriteAdAction = true
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
    
    func favouriteAdSaved(ad: FavouriteAd) {
        self.calledFavouriteAdSaved = true
    }
    
    func favouriteAdRemoved(with propertyCode: String) {
        self.calledFavouriteAdRemoved = true
    }
}
    

    


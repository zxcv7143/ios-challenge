//
//  MockSaveFavouriteAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
@testable import Ads
import Foundation

class MockSaveFavouriteAdUseCase: SaveFavouriteAdProtocol {
    
    var adId: String = "1"
    
    var localDataManager: AdListLocalDataManagerProtocol = MockAdListLocalDataManager()
    
    func execute() async throws -> (Bool, FavouriteAd) {
        return (true, FavouriteAd())
    }
}

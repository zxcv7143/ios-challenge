//
//  MockCheckFavouriteAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
@testable import Ads

class MockCheckFavouriteAdUseCase: CheckFavouriteAdProtocol {
    var localDataManager: AdListLocalDataManagerProtocol = MockAdListLocalDataManager()
    
    var adId: String = "1"
    
    func execute() async throws -> Bool {
        return true
    }
    
}

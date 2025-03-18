//
//  MockRemoveFavouriteAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
@testable import Ads
import Foundation

class MockRemoveFavouriteAdUseCase: RemoveFavouriteAdProtocol {
    var adId: String = "1"
    
    var localDataManager: AdListLocalDataManagerProtocol = MockAdListLocalDataManager()
    
    func execute() async throws -> Bool {
        return true
    }
}

//
//  MockFetchFavouriteAdSavingDateUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
@testable import Ads
import Foundation

class MockFetchFavouriteAdSavingDateUseCase: FetchFavouriteAdSavingDateProtocol {
    var adId: String = "1"
    
    var localDataManager: AdListLocalDataManagerProtocol = MockAdListLocalDataManager()
    
    func execute() async throws -> Date? {
        return Date()
    }
}


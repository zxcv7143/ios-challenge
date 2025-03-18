//
//  FetchFavouriteAdSavingDateUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//

import Foundation
// MARK: Use case protocol
@MainActor
protocol FetchFavouriteAdSavingDateProtocol: UseCase where Output == Date? {
    var adId: String { get }
    var localDataManager: AdListLocalDataManagerProtocol { get }
}

// MARK: - Execute extension
@MainActor
class FetchFavouriteAdSavingDateUseCase: FetchFavouriteAdSavingDateProtocol {
    
    let localDataManager: AdListLocalDataManagerProtocol = AdListLocalDataManager()
    let adId: String
    
    init(adId: String) {
        self.adId = adId
    }
    
    func execute() async -> Date? {
        return localDataManager.fetchFavouriteAdSavingDate(by: adId)
    }
}

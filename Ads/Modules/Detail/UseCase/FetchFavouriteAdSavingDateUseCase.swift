//
//  FetchFavouriteAdSavingDateUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//

import Foundation
// MARK: Use case protocol
protocol FetchFavouriteAdSavingDateProtocol: UseCase where Output == Date? {
    var adId: String { get set}
    var localDataManager: AdListLocalDataManagerProtocol { get }
}

// MARK: - Execute extension
class FetchFavouriteAdSavingDateUseCase: FetchFavouriteAdSavingDateProtocol {
    
    let localDataManager: AdListLocalDataManagerProtocol = AdListLocalDataManager()
    var adId: String = ""
    
    func execute() async -> Date? {
        return localDataManager.fetchFavouriteAdSavingDate(by: adId)
    }
}

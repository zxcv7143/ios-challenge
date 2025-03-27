//
//  SaveFavouriteAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//

import Foundation

// MARK: Use case protocol
protocol SaveFavouriteAdProtocol: UseCase where Output == (Bool, FavouriteAd) {
    var adId: String { get set }
    var localDataManager: AdListLocalDataManagerProtocol { get }
}

// MARK: - Execute extension
class SaveFavouriteAdUseCase: SaveFavouriteAdProtocol {
    
    let localDataManager: AdListLocalDataManagerProtocol = AdListLocalDataManager()
    var adId: String = ""
    
    func execute() async throws -> (Bool, FavouriteAd) {
        try await withCheckedThrowingContinuation { continuation in
            localDataManager.saveFavouriteAd(propertyCode: adId) { saved, savedAd in
                guard let savedAd else { return }
                saved ? continuation.resume(returning: (true, savedAd)) : continuation.resume(throwing: CoreDataError.errorSavingData)
            }
        }
    }
}



//
//  RemoveFAvouriteAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//

import Foundation

// MARK: Use case protocol
@MainActor
protocol RemoveFavouriteAdProtocol: UseCase where Output == Bool {
    var adId: String { get }
    var localDataManager: AdListLocalDataManagerProtocol { get }
}

// MARK: - Execute extension
@MainActor
class RemoveFavouriteAdUseCase: RemoveFavouriteAdProtocol {
    
    let localDataManager: AdListLocalDataManagerProtocol = AdListLocalDataManager()
    let adId: String
    
    init(adId: String) {
        self.adId = adId
    }
    
    func execute() async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            localDataManager.removeFavouriteAd(propertyCode: adId) { removed in
                removed ? continuation.resume(returning: true): continuation.resume(throwing: CoreDataError.errorRemovingData)
            }
        }
    }
}



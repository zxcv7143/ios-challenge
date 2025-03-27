//
//  RemoveFAvouriteAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//

import Foundation

// MARK: Use case protocol
protocol RemoveFavouriteAdProtocol: UseCase where Output == Bool {
    var adId: String { get set }
    var localDataManager: AdListLocalDataManagerProtocol { get }
}

// MARK: - Execute extension
class RemoveFavouriteAdUseCase: RemoveFavouriteAdProtocol {
    
    let localDataManager: AdListLocalDataManagerProtocol = AdListLocalDataManager()
    var adId: String = "0"
    
    func execute() async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            localDataManager.removeFavouriteAd(propertyCode: adId) { removed in
                removed ? continuation.resume(returning: true): continuation.resume(throwing: CoreDataError.errorRemovingData)
            }
        }
    }
}



//
//  CheckFavouriteAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
import Foundation

// MARK: Use case protocol
@MainActor
protocol CheckFavouriteAdProtocol: UseCase where Output == Bool {
    var adId: String { get }
    var localDataManager: AdListLocalDataManagerProtocol { get }
}

// MARK: - Execute extension
@MainActor
class CheckFavouriteAdUseCase: CheckFavouriteAdProtocol {
    
    let localDataManager: AdListLocalDataManagerProtocol = AdListLocalDataManager()
    let adId: String
    
    init(adId: String) {
        self.adId = adId
    }
    
    func execute() async -> Bool {
        return localDataManager.isFavouriteAd(propertyCode: adId)
    }
}



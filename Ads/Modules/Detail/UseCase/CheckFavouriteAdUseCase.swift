//
//  CheckFavouriteAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
import Foundation

// MARK: Use case protocol
protocol CheckFavouriteAdProtocol: UseCase where Output == Bool {
    var adId: String { get set }
    var localDataManager: AdListLocalDataManagerProtocol { get }
}

// MARK: - Execute extension
class CheckFavouriteAdUseCase: CheckFavouriteAdProtocol {
    
    let localDataManager: AdListLocalDataManagerProtocol = AdListLocalDataManager()
    var adId: String = "0"
    
    func execute() async -> Bool {
        return localDataManager.isFavouriteAd(propertyCode: adId)
    }
}



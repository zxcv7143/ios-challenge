//
//  DetailAdPageViewModel.swift
//  Ads
//
//  Created by Anton Zuev on 16/3/25.
//
import SwiftUI

protocol DetailAdPageViewModelProtocol: ObservableObject {
    @MainActor func getDetailAd()
    @MainActor func saveFavouriteAd()
    @MainActor func removeFavouriteAd()
    
    var adDetail: AdDetail? { get }
    var ad: Ad? { get }
    var isFavourite: Bool { get }
}

final class DetailAdPageViewModel: DetailAdPageViewModelProtocol {
    
    @Published var adDetail: AdDetail? = nil
    @Published var ad: Ad? = nil
    @Published var isFavourite: Bool = false
    
    var getAdDetailUseCase: any GetDetailAdProtocol = GetDetailAdUseCase()
    var checkFavouriteAdUseCase: (any CheckFavouriteAdProtocol)?
    var removeFavouriteAdUseCase: (any RemoveFavouriteAdProtocol)?
    var saveFavouriteAdUseCase: (any SaveFavouriteAdProtocol)?
    var fetchFavouriteSavingDateUseCase: (any FetchFavouriteAdSavingDateProtocol)?
    
    @MainActor
    func getDetailAd() {
        Task {
            self.adDetail = try await getAdDetailUseCase.execute()
            self.checkFavouriteAdUseCase = CheckFavouriteAdUseCase(adId: String(adDetail?.adid ?? 0))
            self.isFavourite = try await checkFavouriteAdUseCase?.execute() ?? false
            self.fetchFavouriteSavingDateUseCase = FetchFavouriteAdSavingDateUseCase(adId: String(adDetail?.adid ?? 0))
            self.adDetail?.dateSavedAsFavourite = try await fetchFavouriteSavingDateUseCase?.execute()
        }
    }
    
    @MainActor
    func saveFavouriteAd() {
        Task {
            self.saveFavouriteAdUseCase = SaveFavouriteAdUseCase(adId: String(adDetail?.adid ?? 0))
            let result = try await saveFavouriteAdUseCase?.execute()
            self.isFavourite = result?.0 ?? false
            self.adDetail?.dateSavedAsFavourite = result?.1.savingDate
        }
    }
    
    @MainActor
    func removeFavouriteAd() {
        Task {
            self.removeFavouriteAdUseCase = RemoveFavouriteAdUseCase(adId: String(adDetail?.adid ?? 0))
            guard let removed = try await removeFavouriteAdUseCase?.execute() else { return }
            self.isFavourite = removed ? false : true
        }
    }
    
    @MainActor
    init(adDetail: AdDetail? = nil, ad: Ad? = nil) {
        self.adDetail = adDetail
        self.ad = ad
    }
        
}






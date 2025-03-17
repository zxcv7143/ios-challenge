//
//  DetailAdPageViewModel.swift
//  Ads
//
//  Created by Anton Zuev on 16/3/25.
//
import SwiftUI

final class DetailAdPageViewModel: ObservableObject {
    
    @Published var adDetail: AdDetail? = nil
    @Published var ad: Ad? = nil
    @Published var isFavourite: Bool = false
    
    private let getAdDetailUseCase = GetDetailAdUseCase()
    private var checkFavouriteAdUseCase: CheckFavouriteAdUseCase?
    private var removeFavouriteAdUseCase: RemoveFavouriteAdUseCase?
    private var saveFavouriteAdUseCase: SaveFavouriteAdUseCase?
    private var fetchFavouriteSavingDateUseCase: FetchFavouriteAdSavingDateUseCase?
    
    @MainActor
    func getDetailAd() {
        Task {
            self.adDetail = try await getAdDetailUseCase.execute()
            self.checkFavouriteAdUseCase = CheckFavouriteAdUseCase(adId: String(adDetail?.adid ?? 0))
            self.isFavourite = await checkFavouriteAdUseCase?.execute() ?? false
            self.fetchFavouriteSavingDateUseCase = FetchFavouriteAdSavingDateUseCase(adId: String(adDetail?.adid ?? 0))
            self.adDetail?.dateSavedAsFavorite = await fetchFavouriteSavingDateUseCase?.execute()
        }
    }
    
    @MainActor
    func saveFavouriteAd() {
        Task {
            self.saveFavouriteAdUseCase = SaveFavouriteAdUseCase(adId: String(adDetail?.adid ?? 0))
            let result = try await saveFavouriteAdUseCase?.execute()
            self.isFavourite = result?.0 ?? false
            self.adDetail?.dateSavedAsFavorite = result?.1.savingDate
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






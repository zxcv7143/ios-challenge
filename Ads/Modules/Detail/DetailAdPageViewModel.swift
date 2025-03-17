//
//  DetailAdPageViewModel.swift
//  Ads
//
//  Created by Anton Zuev on 16/3/25.
//
import SwiftUI

class DetailAdPageViewModel: ObservableObject {
    
    @Published var adDetail: AdDetail? = nil
    
    private let getAdDetailUseCase = GetDetailAdUseCase()
    
    @MainActor
    func getDetailAd() {
        Task {
            self.adDetail = try await getAdDetailUseCase.execute()
        }
    }
    
    init(adDetail: AdDetail? = nil) {
        self.adDetail = adDetail
    }
        
}






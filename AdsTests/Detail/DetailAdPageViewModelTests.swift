//
//  DetailAdPageViewModelTests.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//

import Testing
@testable import Ads

struct DetailAdPageViewModelTests {
    
    @Test("Test getting detail ad") @MainActor
    func testGetDetailAd() async throws {
        let viewModel = DetailAdPageViewModel()
        viewModel.getAdDetailUseCase = MockGetDetailAdUseCase()
        viewModel.getDetailAd()
        try await Task.sleep(for: .seconds(1))
        #expect(viewModel.adDetail != nil)
    }
    
    @Test("Test saving favourite ad") @MainActor
    func saveFavouriteAd() async throws {
        let viewModel = DetailAdPageViewModel()
        viewModel.saveFavouriteAdUseCase = MockSaveFavouriteAdUseCase()
        viewModel.saveFavouriteAd()
        try await Task.sleep(for: .seconds(1))
        #expect(viewModel.isFavourite)
    }
    
    @Test("Test removing favourite ad") @MainActor
    func removeFavouriteAd() async throws {
        let viewModel = DetailAdPageViewModel()
        viewModel.removeFavouriteAdUseCase = MockRemoveFavouriteAdUseCase()
        viewModel.removeFavouriteAd()
        try await Task.sleep(for: .seconds(1))
        #expect(viewModel.isFavourite == false)
    }
    
}

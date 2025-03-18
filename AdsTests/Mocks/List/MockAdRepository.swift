//
//  MockAdRepository.swift
//  Ads
//
//  Created by Anton Zuev on 18/3/25.
//
@testable import Ads

class MockAdRepository: AdRepositoryProtocol {
    func getAdList() async throws -> [Ad] {
        return mockAds.map{ Ad(dto: $0)}
    }
    
    func getAdDetails() async throws -> AdDetail {
        return mockAdDetail
    }
}

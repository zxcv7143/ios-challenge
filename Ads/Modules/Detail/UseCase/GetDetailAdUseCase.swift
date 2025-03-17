//
//  getDetailAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 16/3/25.
//

import Foundation

// MARK: Use case protocol
protocol GetDetailAdProtocol: UseCase where Output == AdDetail {
}

// MARK: - Execute extension
class GetDetailAdUseCase: GetDetailAdProtocol {
    
    func execute() async throws -> AdDetail {
        guard let url = URL(string: Urls.AdDetail.adDetail) else {
            throw NetworkError.invalidURL
        }
        let result = await NetworkClient().performRequest(url: url, responseType: AdDetailDTO.self)
        switch result {
        case .success(let adDTO):
            return AdDetail(dto: adDTO)
        case .failure:
            throw NetworkError.invalidResponse
        }
    }
}



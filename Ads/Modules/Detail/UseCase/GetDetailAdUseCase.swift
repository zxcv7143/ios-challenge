//
//  getDetailAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 16/3/25.
//

import Foundation

// MARK: Use case protocol
protocol GetDetailAdProtocol: UseCase where Output == AdDetail {
    var repository: AdRepositoryProtocol { get }
}

// MARK: - Execute extension
class GetDetailAdUseCase: GetDetailAdProtocol {
    
    let repository: any AdRepositoryProtocol
    
    init(repository: any AdRepositoryProtocol = AdRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> AdDetail {
        return try await self.repository.getAdDetails()
    }
}



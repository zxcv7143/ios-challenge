//
//  AdRepository.swift
//  Ads
//
//  Created by Anton Zuev on 18/3/25.
//
import Foundation

protocol AdRepositoryProtocol {
    func getAdList() async throws -> [Ad]
    func getAdDetails() async throws -> AdDetail
}

class AdRepository: AdRepositoryProtocol {
    
    let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol = NetworkClient()) {
        self.httpClient = httpClient
    }
    
    func getAdList() async throws -> [Ad] {
        guard let url = URL(string: Urls.AdList.adList) else {
            throw NetworkError.invalidURL
        }
        let result = await httpClient.performRequest(url: url, responseType: [AdDTO].self)
        return try result.map { adListDTO in
            adListDTO.map { dto in
                Ad(dto: dto)
            }
        }.get()
    }
    
    func getAdDetails() async throws -> AdDetail {
        guard let url = URL(string: Urls.AdDetail.adDetail) else {
            throw NetworkError.invalidURL
        }
        let result = await httpClient.performRequest(url: url, responseType: AdDetailDTO.self)
        return try result.map { AdDetail(dto: $0) }.get()
    }
}

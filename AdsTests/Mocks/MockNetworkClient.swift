//
//  MockNetworkClient.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
@testable import Ads
import Foundation

class MockNetworkClient: HTTPClientProtocol {
    
    var response: Decodable
    
    func performRequest<T>(url: URL, responseType: T.Type, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        completion(.success(response as! T))
    }
    
    func performRequest<T>(url: URL, responseType: T.Type) async -> Result<T, any Error> where T : Decodable {
        return .success(response as! T )
    }
    
    init(response: Decodable) {
        self.response = response
    }
    
}


//
//  HTTPClientProtocol.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//


import Foundation


// MARK: - Protocols
protocol HTTPClientProtocol {
    func performRequest<T: Decodable>(url: URL, responseType: T.Type) async -> Result<T, Error>
}


// MARK: - Class
final class NetworkClient: HTTPClientProtocol {

     func performRequest<T: Decodable>(url: URL, responseType: T.Type) async -> Result<T, Error> {
         do {
             let (data, response) = try await URLSession.shared.data(from: url)
             
             guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                 return Result.failure(NetworkError.invalidResponse)
             }
             
             let decodedObject = try JSONDecoder().decode(responseType, from: data)
             return Result.success(decodedObject)
         } catch {
             return Result.failure(NetworkError.invalidData)
         }
    }
}

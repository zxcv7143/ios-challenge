//
//  HTTPClientProtocol.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//


import Foundation


// MARK: - Protocols
protocol HTTPClientProtocol {
    func performRequest<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}


// MARK: - Class
final class NetworkClient: HTTPClientProtocol {
    
    func performRequest<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(NetworkError.errorFetchingData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(NetworkError.errorParsingData))
            }
        }
        task.resume()
    }

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

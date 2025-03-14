//
//  Errors.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//

import Foundation

enum NetworkError: Error {
    case errorFetchingData
    case errorParsingData
    case invalidURL
    case invalidResponse
    case invalidData
}

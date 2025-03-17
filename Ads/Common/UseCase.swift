//
//  UseCase.swift
//  Ads
//
//  Created by Anton Zuev on 16/3/25.
//


import Foundation

public protocol UseCase {
    associatedtype Output

    @discardableResult
    func execute() async throws -> Output
}
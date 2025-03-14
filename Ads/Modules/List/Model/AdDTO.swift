//
//  HomeAdListDTO.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//



import Foundation


struct AdDTO: Codable {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: CGFloat
    let priceInfo: PriceInfoDTO
    let propertyType: String
    let operation: String
    let size: CGFloat
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: CGFloat
    let longitude: CGFloat
    let description: String
    let multimedia: MultimediaDTO
    let features: FeaturesDTO
}

struct PriceInfoDTO: Codable {
    let price: PriceDTO
}

struct PriceDTO: Codable {
    let amount: CGFloat
    let currencySuffix: String
}

struct MultimediaDTO: Codable {
    let images: [ImageDTO]
}

struct ImageDTO: Codable {
    let url: String
    let tag: String
}

struct FeaturesDTO: Codable {
    let hasAirConditioning: Bool?
    let hasBoxRoom: Bool?
    let hasSwimmingPool: Bool?
    let hasTerrace: Bool?
    let hasGarden: Bool?
}

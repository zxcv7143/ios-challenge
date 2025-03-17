//
//  Ad.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//
import Foundation

struct Ad {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: CGFloat
    let priceInfo: PriceInfo
    let propertyType: PropertyType
    let operation: OperationType
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
    let multimedia: MultimediaInfo
    let features: Features
    var isFavourite: Bool = false
    var dateSavedAsFavorite: Date? = nil
    
    init(dto: AdDTO) {
        self.propertyCode = dto.propertyCode
        self.thumbnail = dto.thumbnail
        self.floor = dto.floor
        self.price = dto.price
        self.priceInfo = PriceInfo(amount: dto.priceInfo.price.amount, currencySuffix: dto.priceInfo.price.currencySuffix)
        self.propertyType = PropertyType(rawValue: dto.propertyType) ?? .other
        self.operation = OperationType(rawValue: dto.operation) ?? .other
        self.size = dto.size
        self.exterior = dto.exterior
        self.rooms = dto.rooms
        self.bathrooms = dto.bathrooms
        self.address = dto.address
        self.province = dto.province
        self.municipality = dto.municipality
        self.district = dto.district
        self.country = dto.country
        self.neighborhood = dto.neighborhood
        self.latitude = dto.latitude
        self.longitude = dto.longitude
        self.description = dto.description
        self.multimedia = MultimediaInfo(images: dto.multimedia.images.map { ImageInfo(url: $0.url, tag: $0.tag)})
        self.features = Features(hasAirConditioning: dto.features.hasAirConditioning, hasBoxRoom: dto.features.hasBoxRoom, hasSwimmingPool: dto.features.hasSwimmingPool, hasTerrace: dto.features.hasTerrace, hasGarden: dto.features.hasGarden)
    }
    
    var fullAddress: String {
        return "\(address),\(neighborhood)"
    }
    var fullPrice: String {
        return "\(Double(priceInfo.amount).moneyFormat()) \(priceInfo.currencySuffix)"
    }
}

struct PriceInfo {
    let amount: CGFloat
    let currencySuffix: String
}

struct MultimediaInfo {
    let images: [ImageInfo]
}

struct ImageInfo {
    let url: String
    let tag: String
}

struct Features {
    let hasAirConditioning: Bool?
    let hasBoxRoom: Bool?
    let hasSwimmingPool: Bool?
    let hasTerrace: Bool?
    let hasGarden: Bool?
}

enum OperationType: String {
    case sale
    case rent
    case other
}

enum PropertyType: String {
    case flat
    case other
}



//
//  MockAdList.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
@testable import Ads


let mockAds = [AdDTO(propertyCode: "1", thumbnail: "url", floor: "1", price: 100000.0, priceInfo: PriceInfoDTO(price: PriceDTO(amount: 10000, currencySuffix: "€")), propertyType: "flat", operation: "sale", size: 100.0, exterior: true, rooms: 2, bathrooms: 1, address: "Calle Fortuny", province: "Madrid", municipality: "Madrid", district: "Chamberí", country: "Spain", neighborhood: "Almagro", latitude: 100.0, longitude: 100.0, description: "New flat", multimedia: MultimediaDTO(images: [ImageDTO(url: "http://picsum.photos/300/300", tag: "1")]), features: FeaturesDTO(hasAirConditioning: true, hasBoxRoom: false, hasSwimmingPool: false, hasTerrace: false, hasGarden: false))]

//
//  AdDetail.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//

import Foundation


struct AdDetail {
    let adid: Int
    let price: CGFloat
    let priceInfo: PriceInfo
    let operation: OperationType
    let propertyType: PropertyType
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: MultimediaInfo
    let propertyComment: String
    let ubication: Ubication
    let country: String
    let moreCharacteristics: Characteristics
    let energyCertification: EnergyCertification
    var isFavorite: Bool = false
    var dateSavedAsFavorite: Date? = nil
    
    init(dto: AdDetailDTO) {
        self.adid = dto.adid
        self.price = dto.price
        self.priceInfo = PriceInfo(amount: dto.priceInfo.amount, currencySuffix: dto.priceInfo.currencySuffix)
        self.propertyType = PropertyType(rawValue: dto.propertyType) ?? .other
        self.operation = OperationType(rawValue: dto.operation) ?? .other
        self.extendedPropertyType = dto.extendedPropertyType
        self.homeType = dto.homeType
        self.state = dto.state
        self.multimedia = MultimediaInfo(images: dto.multimedia.images.map { ImageInfo(url: $0.url, tag: $0.tag)})
        self.propertyComment = dto.propertyComment
        self.ubication = Ubication(latitude: dto.ubication.latitude, longitude: dto.ubication.longitude)
        self.country = dto.country
        self.moreCharacteristics = Characteristics(communityCosts: dto.moreCharacteristics.communityCosts, roomNumber: dto.moreCharacteristics.roomNumber, bathNumber: dto.moreCharacteristics.bathNumber, exterior: dto.moreCharacteristics.exterior, housingFurnitures: dto.moreCharacteristics.housingFurnitures, agencyIsABank: dto.moreCharacteristics.agencyIsABank, energyCertificationType: dto.moreCharacteristics.energyCertificationType, flatLocation: dto.moreCharacteristics.flatLocation, modificationDate: dto.moreCharacteristics.modificationDate, constructedArea: dto.moreCharacteristics.constructedArea, lift: dto.moreCharacteristics.lift, boxroom: dto.moreCharacteristics.boxroom, isDuplex: dto.moreCharacteristics.isDuplex, floor: dto.moreCharacteristics.floor, status: dto.moreCharacteristics.status)
        self.energyCertification = EnergyCertification(title: dto.energyCertification.title, energyConsumptionType: EnergyConsumption(type: dto.energyCertification.energyConsumption.type), emissionType: Emissions(type: dto.energyCertification.emissions.type))
    }
    
    var characteristicString: String {
        return "\(moreCharacteristics.roomNumber) \("Rooms".localized), \(moreCharacteristics.bathNumber) \("Bathrooms".localized), \(moreCharacteristics.exterior ? "exterior" : "interior")"
    }
    
    var fullPrice: String {
        return "\(Double(priceInfo.amount).moneyFormat()) \(priceInfo.currencySuffix)"
    }
}

struct Ubication {
    let latitude: CGFloat
    let longitude: CGFloat
}

struct Characteristics {
    let communityCosts: CGFloat
    let roomNumber: Int
    let bathNumber: Int
    let exterior: Bool
    let housingFurnitures: String
    let agencyIsABank: Bool
    let energyCertificationType: String
    let flatLocation: String
    let modificationDate: Int
    let constructedArea: Int
    let lift: Bool
    let boxroom: Bool
    let isDuplex: Bool
    let floor: String
    let status: String
}

struct EnergyCertification {
    let title: String
    let energyConsumptionType: EnergyConsumption
    let emissionType: Emissions
}

struct EnergyConsumption {
    let type: String
}

struct Emissions {
    let type: String
}

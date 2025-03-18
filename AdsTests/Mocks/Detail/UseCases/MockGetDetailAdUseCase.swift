//
//  MockGetDetailAdUseCase.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
@testable import Ads
import Foundation

class MockGetDetailAdUseCase: GetDetailAdProtocol {
    func execute() async throws -> AdDetail {
        return AdDetail(dto: AdDetailDTO(adid: 1, price: 100.0, priceInfo: PriceDTO(amount: 100.0, currencySuffix: "€"), operation: "sell", propertyType: "home", extendedPropertyType: "home", homeType: "home", state: "state", multimedia: MultimediaDTO(images: [ImageDTO(url: "url", tag: "1")]), propertyComment: "Piso nuevo", ubication: UbicationDTO(latitude: 100.0, longitude: 100.0), country: "Spain", moreCharacteristics: CharacteristicsDTO(communityCosts: 100.0, roomNumber: 3, bathNumber: 1, exterior: true, housingFurnitures: "todo", agencyIsABank: false, energyCertificationType: "E", flatLocation: "Madrid", modificationDate: 1, constructedArea: 100, lift: true, boxroom: false, isDuplex: false, floor: "3", status: "state"), energyCertification: EnergyCertificationDTO(title: "E", energyConsumption: EnergyConsumptionDTO(type: "A"), emissions: EmissionsDTO(type: "A"))))
    }
    
    
}

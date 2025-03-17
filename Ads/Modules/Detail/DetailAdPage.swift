//
//  DetailAdPage.swift
//  Ads
//
//  Created by Anton Zuev on 16/3/25.
//
import SwiftUI

struct DetailAdPage: View {
    
    let carrouselHeight = UIScreen.main.bounds.height * 0.4
    @ObservedObject var viewModel: DetailAdPageViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                TabView {
                    ForEach(viewModel.adDetail?.multimedia.images ?? [], id: \.url) { image in
                        AsyncImage(url: URL(string: image.url)) { image in
                            image.resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }.tabViewStyle(.page).frame(height: carrouselHeight)
                
                HStack() {
                    Text(viewModel.adDetail?.fullPrice ?? "")
                    Button {
                        viewModel.adDetail?.isFavorite.toggle()
                    } label: {
                        Image(systemName: (viewModel.adDetail?.isFavorite ?? false ? "star.fill" : "star")).foregroundColor(.red)
                    }
                }
    
                Text(viewModel.adDetail?.propertyComment ?? "")
                    .font(.body)
                    .padding()
            }.onAppear {
                viewModel.getDetailAd()
            }
        }.navigationTitle(viewModel.adDetail?.operation ?? "")
    }
}
    
    
#Preview {
    NavigationView {
        DetailAdPage(viewModel: DetailAdPageViewModel(adDetail: AdDetail(dto: AdDetailDTO(adid: 1, price: 100000, priceInfo: PriceDTO(amount: 1000.0, currencySuffix: "€"), operation: "sell", propertyType: "flat", extendedPropertyType: "flat", homeType: "flat", state: "state", multimedia: MultimediaDTO(images: [ImageDTO(url: "https://picsum.photos/300/300", tag: "photo")]), propertyComment: "comment", ubication: UbicationDTO(latitude: 100.0, longitude: 100.0), country: "Spain", moreCharacteristics: CharacteristicsDTO(communityCosts: 100.0, roomNumber: 3, bathNumber: 3, exterior: true, housingFurnitures: "", agencyIsABank: false, energyCertificationType: "A", flatLocation: "Madrid", modificationDate: 1, constructedArea: 100, lift: true, boxroom: false, isDuplex: false, floor: "2", status: ""), energyCertification: EnergyCertificationDTO(title: "title", energyConsumption: EnergyConsumptionDTO(type: "A"), emissions: EmissionsDTO(type: "A"))))))
    }.background(Color.idealista)
    
}







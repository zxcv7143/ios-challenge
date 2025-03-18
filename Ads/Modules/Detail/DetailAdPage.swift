//
//  DetailAdPage.swift
//  Ads
//
//  Created by Anton Zuev on 16/3/25.
//
import SwiftUI

struct DetailAdPage<ViewModel>: View where ViewModel: DetailAdPageViewModelProtocol {
    
    let carrouselHeight = UIScreen.main.bounds.height * 0.4
    
    @State var showMap = false
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if showMap, let ad = viewModel.ad {
                    MapView(ads: [ad])
                        .frame(height: carrouselHeight)
                } else {
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
                }
                if viewModel.isFavourite {
                    HStack() {
                        Text("\("AdSavedDate".localized) \(viewModel.adDetail?.dateSavedAsFavourite?.formattedDate() ?? "")")
                            .font(.system(size: 10, weight: .light, design: .default)).padding(.trailing)
                    }
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.adDetail?.characteristicString ?? "")
                            .font(.system(size: 15, weight: .light, design: .default))
                        
                        Text(viewModel.adDetail?.fullPrice ?? "")
                            .font(.system(size: 20, weight: .bold, design: .default))
                    }.padding()
                    Spacer()
                    Button {
                        showMap.toggle()
                    } label: {
                        Image(systemName: "map").foregroundColor(.black)
                    }.padding()
                    
                    VStack {
                        Button {
                            if viewModel.isFavourite {
                                viewModel.removeFavouriteAd()
                            } else {
                                viewModel.saveFavouriteAd()
                            }
                        } label: {
                            Image(systemName: (viewModel.isFavourite ? "star.fill" : "star")).foregroundColor(.red)
                        }
                        
                    }.padding()
                    
                }
                Text(viewModel.adDetail?.propertyComment ?? "")
                    .font(.system(size: 15, weight: .light, design: .default))
                    .padding()
            }.onAppear {
                viewModel.getDetailAd()
            }
        }.navigationTitle(viewModel.adDetail?.extendedPropertyType.localized ?? "")
    }
}
    
    
#Preview {
    NavigationView {
        DetailAdPage(viewModel: DetailAdPageViewModel(adDetail: AdDetail(dto: AdDetailDTO(adid: 1, price: 100000, priceInfo: PriceDTO(amount: 1000.0, currencySuffix: "€"), operation: "sell", propertyType: "flat", extendedPropertyType: "flat", homeType: "flat", state: "state", multimedia: MultimediaDTO(images: [ImageDTO(url: "https://picsum.photos/300/300", tag: "photo")]), propertyComment: "comment", ubication: UbicationDTO(latitude: 100.0, longitude: 100.0), country: "Spain", moreCharacteristics: CharacteristicsDTO(communityCosts: 100.0, roomNumber: 3, bathNumber: 3, exterior: true, housingFurnitures: "", agencyIsABank: false, energyCertificationType: "A", flatLocation: "Madrid", modificationDate: 1, constructedArea: 100, lift: true, boxroom: false, isDuplex: false, floor: "2", status: ""), energyCertification: EnergyCertificationDTO(title: "title", energyConsumption: EnergyConsumptionDTO(type: "A"), emissions: EmissionsDTO(type: "A"))))))
    }.background(Color.idealista)
    
}







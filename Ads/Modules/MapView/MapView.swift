//
//  MapView.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region: MKCoordinateRegion
    private var annotations: [AnnotationItem]
    
    init(ads: [Ad]) {
        self.annotations = []
        for ad in ads {
            let latitude = ad.latitude
            let longitude = ad.longitude
            self.annotations.append(AnnotationItem(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), address: ad.address))
        }
        let minLatitude = annotations.map { $0.coordinate.latitude }.min() ?? 0
        let maxLatitude = annotations.map { $0.coordinate.latitude }.max() ?? 0
        let minLongitude = annotations.map { $0.coordinate.longitude }.min() ?? 0
        let maxLongitude = annotations.map { $0.coordinate.longitude }.max() ?? 0
        let latitude = (minLatitude + maxLatitude) / 2
        let longitude = (minLongitude + maxLongitude) / 2
        var latitudeDelta = (maxLatitude - minLatitude) * 2
        var longitudeDelta = (maxLongitude - minLongitude) * 2
        
        if latitudeDelta == 0 {
            latitudeDelta = 0.008
        }
        
        if longitudeDelta == 0 {
            longitudeDelta = 0.008
        }
        
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: latitudeDelta , longitudeDelta: longitudeDelta)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { item in
            MapAnnotation(coordinate: item.coordinate) {
                   VStack {
                       Text(item.address)
                           .font(.caption)
                           .foregroundColor(Color.black)
                           .padding(4)
                           .background(Color.idealista)
                           .cornerRadius(8)
                           .offset(y: -25)

                       Image(systemName: "mappin.and.ellipse")
                           .resizable()
                           .scaledToFit()
                           .frame(height: 40)
                           .foregroundColor(.black)
                           .offset(y: -35)
                   }
               }
        }
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("mapView")
    }
}

struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let address: String
}

#Preview {
    MapView(ads: [Ad(dto: AdDTO(propertyCode: "1", thumbnail: "", floor: "1", price: 100000.0, priceInfo: PriceInfoDTO(price: PriceDTO(amount: 100000.0, currencySuffix: "€")), propertyType: "flat", operation: "sell", size: 100.0, exterior: true, rooms: 3, bathrooms: 1, address: "calle Fortuny", province: "Madrid", municipality: "Madrid", district: "Chamberí", country: "España", neighborhood: "Almagro", latitude: 100.0, longitude: 100.0, description: "", multimedia: MultimediaDTO(images: [ImageDTO(url: "http://picsum.photos/300/300", tag: "1")]), features: FeaturesDTO(hasAirConditioning: true, hasBoxRoom: true, hasSwimmingPool: true, hasTerrace: true, hasGarden: false)))])
}





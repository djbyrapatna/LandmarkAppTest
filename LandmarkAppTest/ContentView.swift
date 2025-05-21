//
//  ContentView.swift
//  LandmarkAppTest
//
//  Created by Dhruva Jothik Byrapatna on 5/21/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = LandmarkViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242), // NYC
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: viewModel.landmarks){ landmark in
            MapMarker(coordinate: landmark.coordinate, tint: .blue)
            
        }
        .edgesIgnoringSafeArea(.all)
        .task{
            await viewModel.fetchLandmarks()
        }
    }
}

#Preview {
    ContentView()
}

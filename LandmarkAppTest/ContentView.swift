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
    @State private var selectedLandmark: Landmark?
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Explore New York!").font(.largeTitle)
                Map(coordinateRegion: $region, annotationItems: viewModel.landmarks){ landmark in
                    MapAnnotation(coordinate: landmark.coordinate){
                        VStack{
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.green)
                            Text(landmark.name)
                                .font(.caption)
                                .fixedSize()
                        }
                        .onTapGesture{
                            selectedLandmark = landmark
                        }
                    }
                    
                }
                .frame(height:500)
                ForEach(viewModel.landmarks) { landmark in
                    HStack{
                        Button(action: {
                            centerMap(on: landmark)
                            selectedLandmark = landmark
                        }) {
                            Text(landmark.name)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        NavigationLink(destination: TravelDetailView(landmark: landmark)) {
                            Label("Travel Details", systemImage: "car")
                        }
                        
                    }
                    
                }
            }
            
            
            .task{
                await viewModel.fetchLandmarks()
            }
            
            .sheet(item: $selectedLandmark) { landmark in
                LandmarkDetailView(landmark: landmark)
            }
        }
    }
    
    func centerMap(on landmark: Landmark) {
        withAnimation {
            region.center = landmark.coordinate
        }
    }
}



#Preview {
    ContentView()
}

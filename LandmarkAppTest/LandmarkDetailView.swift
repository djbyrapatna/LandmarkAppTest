//
//  LandmarkDetailView.swift
//  LandmarkAppTest
//
//  Created by Dhruva Jothik Byrapatna on 5/21/25.
//

import Foundation
import CoreLocation
import SwiftUI
import SafariServices

struct LandmarkDetailView: View {
    let landmark: Landmark
    @State private var showWiki = false

    var body: some View {
        VStack(spacing: 20) {
            Text(landmark.name)
                .font(.largeTitle)
                .bold()
            Text("Latitude: \(landmark.latitude)")
            Text("Longitude: \(landmark.longitude)")
            Button("Open Wikipedia page"){
                showWiki = true
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showWiki) {
                    if let url = wikipediaURL(for: landmark.name) {
                        SafariView(url: url)
                    } else {
                        Text("Invalid URL")
                    }
                }
    }
    func wikipediaURL(for title: String) -> URL? {
            let encoded = title.replacingOccurrences(of: " ", with: "_")
            return URL(string: "https://en.wikipedia.org/wiki/\(encoded)")
        }
}

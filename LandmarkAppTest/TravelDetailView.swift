//
//  TravelDetailView.swift
//  LandmarkAppTest
//
//  Created by Dhruva Jothik Byrapatna on 5/21/25.
//

import Foundation
import SwiftUI

struct TravelDetailView: View {
    let landmark: Landmark

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Travel Details for \(landmark.name)")
                .font(.title)
                .bold()

            Text("""
                To get to \(landmark.name), you can use your preferred mode of transportation.

                • If driving, use Apple Maps or Google Maps and enter the coordinates:
                \(landmark.latitude), \(landmark.longitude)

                • Public transportation may be available depending on your city.

                • Walking or biking is a great option if you're nearby!

                (This is just placeholder text.)
                """)

            Spacer()
        }
        .padding()
        .navigationTitle("Travel Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

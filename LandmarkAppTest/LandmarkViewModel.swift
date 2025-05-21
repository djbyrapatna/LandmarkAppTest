//
//  LandmarkViewModel.swift
//  LandmarkAppTest
//
//  Created by Dhruva Jothik Byrapatna on 5/21/25.
//

import Foundation

@MainActor
class LandmarkViewModel: ObservableObject{
    @Published var landmarks: [Landmark] = []
    
    
    func fetchLandmarks() async {
        //guard let url = URL(string: "https://example.com/landmarks.json") else { return }
        guard let url = Bundle.main.url(forResource: "landmark", withExtension: "json") else {
                print("Failed to find landmark.json in bundle.")
                return
            }
        do{
            //let (data, _) = try await URLSession.shared.data(from: url)
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Landmark].self, from: data)
            self.landmarks = decoded
        }
        catch{
            print("Failed to fetch. Error: \(error)")
        }
    }
}

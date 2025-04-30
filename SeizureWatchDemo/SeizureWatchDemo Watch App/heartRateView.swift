//
//  heartRateView.swift
//  SeizureWatchDemo Watch App
//
//  Created by Raghad Mohsen on 11/12/2024.
//

import SwiftUI

struct heartRateView: View {
    @StateObject private var healthKitManager = HealthKitManager() // Initialize HealthKitManager as an observable object
    var body: some View {

        HStack() {
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
                .opacity(0.3)
                
            
            // Display Heart Rate
            if let heartRate = healthKitManager.heartRate {
                Text("\(heartRate) bpm") // Show the current heart rate
                    .font(.title2)
                    .foregroundColor(.red)
                    .font(.system(size: 14))// Red text for emphasis
            } else {
                Text(" -- bpm") // Placeholder if no data is available
                    
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            
        }.frame(maxWidth: .infinity,alignment: .leading)
         .padding(.horizontal,15)
    }
}

#Preview {
    heartRateView()
}

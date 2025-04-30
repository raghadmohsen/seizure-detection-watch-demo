//
//  ContentView.swift
//  SeizureWatchDemo Watch App
//
//  Created by Raghad Mohsen on 11/12/2024.
//

import SwiftUI


// Main view displaying health data (Heart Rate, HRV, and activity)
struct ContentView: View {
    @StateObject private var healthKitManager = HealthKitManager() // Initialize HealthKitManager as an observable object
    
    var body: some View {
        Color("Background")
            .ignoresSafeArea()
            .overlay {
                VStack {
                    
                    heartRateView()
                        .padding(.bottom, 10)
                    //            Text("Health Data") // Title
                    //                .font(.headline)
                    
                    ZStack{
                        
                        if let predictionValue = healthKitManager.epilepsyPredictionValue {
                            Text("Epilepsy Prediction:\n \(predictionValue * 100, specifier: "%.2f")%") // Display as Double
                            //.font(.headline)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5, x: 3, y: 3)
                                .padding()
                        } else {
                            Text("No Prediction")
                                .shadow(color: .black, radius: 5, x: 3, y: 3)
                        }
                        
                    }
                    
                    // Display Heart Rate Variability (HRV)
                    if let hrv = healthKitManager.hrv {
                        if hrv < 50 {
                            Text("HRV: \(hrv, specifier: "%.2f") ms") // HRV in milliseconds
                                .foregroundColor(.pink)
                                .opacity(0.6)
                        }else if hrv > 50 && hrv < 70 {
                            Text("HRV: \(hrv, specifier: "%.2f") ms") // HRV in milliseconds
                                .foregroundColor(.orange)
                                .opacity(0.6)
                        }else {
                            Text("HRV: \(hrv, specifier: "%.2f") ms")
                                .foregroundColor(.green)
                                .opacity(0.6)
                        }
                        
                    } else {
                        Text("HRV: -- ms") // Placeholder if no HRV data is available
                            .foregroundColor(.gray)
                    }
                }
                .padding() // Add padding to the UI elements
                .onAppear {
                    healthKitManager.requestAuthorization() // Request permission to access HealthKit data
                    NotificationManager.shared.requestPermission()
                    healthKitManager.startMonitoringActivity() // Start monitoring motion activity
                    VitalSignsMonitor.shared.startMonitoring()
                }
            }
    }
}


#Preview {
    ContentView()
}

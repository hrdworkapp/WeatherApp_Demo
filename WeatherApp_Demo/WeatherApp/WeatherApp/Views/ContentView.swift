//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ssm on 29/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("My Location")
                        .font(.largeTitle)
                    Text(viewModel.locationName)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("\(viewModel.currentWeather?.temp ?? 00, specifier: "%.1f")°C |")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("\(viewModel.currentWeather?.weather.first?.description ?? "Unknown")")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                .padding()
                Divider()
                
                if let currentWeather = viewModel.currentWeather {
                    List(viewModel.dailyWeather) { day in
                        NavigationLink(destination: WeatherDetailView(dailyWeather: day)) {
                            WeatherRowView(dailyWeather: day)
                        }
                    }
                } else {
                    Text("Loading...")
                        .padding()
                }
            }
            .navigationTitle("Weather")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

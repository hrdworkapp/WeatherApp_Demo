//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Ssm on 29/06/24.
//

import SwiftUI

struct WeatherDetailView: View {
    var dailyWeather: DailyWeather

    var body: some View {
        VStack {
            Text("Day Temperature: \(dailyWeather.temp.day, specifier: "%.1f")°C")
            Text("Min Temperature: \(dailyWeather.temp.min, specifier: "%.1f")°C")
            Text("Max Temperature: \(dailyWeather.temp.max, specifier: "%.1f")°C")
            Text("Description: \(dailyWeather.weather.first?.description ?? "N/A")")
        }
        .navigationTitle("Weather Details")
    }
}


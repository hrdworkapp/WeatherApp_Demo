//
//  WeatherRowView.swift
//  WeatherApp
//
//  Created by Ssm on 29/06/24.
//

import SwiftUI

struct WeatherRowView: View {
    var dailyWeather: DailyWeather

    var body: some View {
        HStack {
            Text("\(dailyWeather.day)")
                .font(.headline)
                .frame(width: 50, alignment: .leading)
            Spacer()
            Text("\(dailyWeather.temp.day, specifier: "%.1f")°C")
                .font(.subheadline)
                .frame(width: 50, alignment: .leading)
            Spacer()
            Text(dailyWeather.weather.first?.description ?? "N/A")
                .font(.subheadline)
                .frame(width: 100, alignment: .leading)
        }
    }
}


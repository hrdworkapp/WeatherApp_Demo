//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Ssm on 29/06/24.
//

import Foundation

class WeatherService {
    private let apiKey = "f83b8f1b5d8cd32c5002e61339259eca"
    private let baseUrl = "https://api.openweathermap.org/data/3.0/onecall"

    func fetchWeatherData(lat: Double, lon: Double) async throws -> WeatherResponse {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            throw URLError(.badURL)
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "exclude", value: "minutely,hourly"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Print JSON data
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            print(json)
        } else {
            print("Failed to convert data to JSON")
        }
        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return weatherResponse
    }
}

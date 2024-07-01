//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Ssm on 29/06/24.
//

import Foundation

import Foundation

struct WeatherResponse: Codable {
    let current: CurrentWeather
    let timezoneOffset: Int
    let lat: Double
    let lon: Double
    let timezone: String
    let daily: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case current
        case timezoneOffset = "timezone_offset"
        case lat
        case lon
        case timezone
        case daily
    }
}

struct CurrentWeather: Codable {
    let clouds: Int
    let dewPoint: Double
    let dt: Int
    let feelsLike: Double
    let humidity: Int
    let pressure: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let uvi: Double
    let visibility: Int
    let weather: [Weather]
    let windDeg: Int
    let windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case clouds
        case dewPoint = "dew_point"
        case dt
        case feelsLike = "feels_like"
        case humidity
        case pressure
        case sunrise
        case sunset
        case temp
        case uvi
        case visibility
        case weather
        case windDeg = "wind_deg"
        case windSpeed = "wind_speed"
    }
}

struct DailyWeather: Codable, Identifiable {
    var id: Int { dt }
    
    var day: String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
    let clouds: Int
    let dewPoint: Double
    let dt: Int
    let feelsLike: FeelsLike
    let humidity: Int
    let moonPhase: Double
    let moonrise: Int
    let moonset: Int
    let pop: Double
    let pressure: Int
    let summary: String
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let uvi: Double
    let weather: [Weather]
    let windDeg: Int
    let windGust: Double
    let windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case clouds
        case dewPoint = "dew_point"
        case dt
        case feelsLike = "feels_like"
        case humidity
        case moonPhase = "moon_phase"
        case moonrise
        case moonset
        case pop
        case pressure
        case summary
        case sunrise
        case sunset
        case temp
        case uvi
        case weather
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case windSpeed = "wind_speed"
    }
}

struct FeelsLike: Codable {
    let day: Double
    let eve: Double
    let morn: Double
    let night: Double
}

struct Temp: Codable {
    let day: Double
    let eve: Double
    let max: Double
    let min: Double
    let morn: Double
    let night: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
    let id: Int
    let main: String
}

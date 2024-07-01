//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Ssm on 29/06/24.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    func testWeatherService() async {
        let weatherService = WeatherService()
        
        do {
            let weatherData = try await weatherService.fetchWeatherData(lat: 37.7749, lon: -122.4194)
            XCTAssertNotNil(weatherData.current)
            XCTAssertGreaterThan(weatherData.daily.count, 0)
        } catch {
            XCTFail("WeatherService fetchWeatherData failed: \(error.localizedDescription)")
        }
    }
}

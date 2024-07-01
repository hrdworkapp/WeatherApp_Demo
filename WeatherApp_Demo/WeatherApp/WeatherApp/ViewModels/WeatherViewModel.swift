//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ssm on 29/06/24.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel:NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentWeather: CurrentWeather?
    @Published var locationName: String = "Loading..."
    @Published var dailyWeather: [DailyWeather] = []
    @Published var errorMessage: String?
    
    private let weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()
    private let geocoder = CLGeocoder()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        Task {
            do {
                let weatherData = try await weatherService.fetchWeatherData(lat: lat, lon: lon)
                DispatchQueue.main.async {
                    self.currentWeather = weatherData.current
                    self.dailyWeather = weatherData.daily
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            fetchWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            reverseGeocode(location: location)
//            locationManager.stopUpdatingLocation()  // Stop updating to save battery
        }
    }
    
    private func reverseGeocode(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let placemark = placemarks?.first {
                self.locationName = placemark.locality ?? "Unknown Location"
            } else {
                self.locationName = "Unknown Location"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Failed to find user's location: \(error.localizedDescription)"
    }
}

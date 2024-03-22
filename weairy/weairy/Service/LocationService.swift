//
//  LocationService.swift
//  weairy
//
//  Created by do hee kim on 2024/03/22.
//

import Combine
import CoreLocation
import Foundation

protocol LocationService {
    func fetchCurrentLocationCoordinates() -> CLLocationCoordinate2D?
}

class LocationServiceImpl: LocationService {
    
    private var subscriptions = Set<AnyCancellable>()
    
}

extension LocationServiceImpl {
    
    func fetchCurrentLocationCoordinates() -> CLLocationCoordinate2D? {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        guard let location = manager.location else { return nil }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}

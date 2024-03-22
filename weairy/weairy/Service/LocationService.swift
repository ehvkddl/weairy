//
//  LocationService.swift
//  weairy
//
//  Created by do hee kim on 2024/03/22.
//

import Combine
import CoreLocation
import Foundation
import MapKit

protocol LocationService {
    var searchResultsPublisher: AnyPublisher<[MKLocalSearchCompletion], Never> { get }
    
    func fetchCurrentLocationCoordinates() -> CLLocationCoordinate2D?
    
    func searchCityNames(for input: String)
    
    func fetchCoordinates(for completion: MKLocalSearchCompletion) async -> CLLocationCoordinate2D?
}

class LocationServiceImpl: NSObject, LocationService {
    
    private var subscriptions = Set<AnyCancellable>()

    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResultsSubject = PassthroughSubject<[MKLocalSearchCompletion], Never>()
    var searchResultsPublisher: AnyPublisher<[MKLocalSearchCompletion], Never> {
        return searchResultsSubject.eraseToAnyPublisher()
    }
    
    override init() {
        super.init()
        
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }
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

extension LocationServiceImpl: MKLocalSearchCompleterDelegate {
    
    func searchCityNames(for input: String) {
        searchCompleter.queryFragment = input
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResultsSubject.send(completer.results)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        searchResultsSubject.send([])
    }
    
}

extension LocationServiceImpl {
    
    func fetchCoordinates(for completion: MKLocalSearchCompletion) async -> CLLocationCoordinate2D? {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)

        do {
            let response = try await search.start()
            return response.mapItems.first?.placemark.coordinate
        } catch {
            return nil
        }
    }
    
}

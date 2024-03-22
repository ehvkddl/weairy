//
//  CitySearchViewModel.swift
//  weairy
//
//  Created by do hee kim on 2024/03/22.
//

import Combine
import Foundation
import MapKit

class CitySearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var searchResults = [MKLocalSearchCompletion]()

    private var services: Service
    private var cancellables = Set<AnyCancellable>()
    
    init(services: Service) {
        self.services = services
        
        bind()
    }
    
    func bind() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] query in
                guard let `self` else { return }
                
                services.locationService.searchCityNames(for: query)
            }
            .store(in: &cancellables)
        
        services.locationService.searchResultsPublisher
            .sink{ [weak self] results in
                guard let `self` else { return }
                
                searchResults = results
            }
            .store(in: &cancellables)
    }
    
}

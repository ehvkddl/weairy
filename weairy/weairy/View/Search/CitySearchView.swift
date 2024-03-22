//
//  SearchView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/22.
//

import SwiftUI

struct CitySearchView: View {
    @StateObject var vm: CitySearchViewModel
    
    @Binding var selectedCoordinates: Coordinate?
    @Binding var showCitySerachView: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                showCitySerachView = false
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.darkBlue)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            // MARK: - Localization
            Text("Localization")
                .font(WFont.style(.poppin, weight: .semiBold, size: 17))
                .foregroundStyle(.darkBlue)
                .padding(.top, 10)
            
            TextField("도시 검색", text: $vm.searchQuery)
                .frame(height: 40)
                .padding(.horizontal, 14)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.tertiary, lineWidth: 1)
                }
            
            // MARK: - Suggestion
            Text("Suggestion")
                .font(WFont.style(.poppin, weight: .semiBold, size: 15))
                .foregroundStyle(.secondary)
                .opacity(vm.searchResults.isEmpty ? 0 : 1)
                .padding(.top, 15)
            
            ScrollView {
                ForEach(vm.searchResults, id: \.self) { result in
                    LazyVStack {
                        SuggestionItemView(title: result.title) {
                            Task {
                                guard let coordinate = await vm.getCoordinates(of: result) else {
                                    selectedCoordinates = nil
                                    return
                                }
                                selectedCoordinates = Coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            }
                            
                            showCitySerachView = false
                        }
                        .frame(height: 45)
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            .padding(.top, 10)
            
        }
        .padding(20)
    }
}

#Preview {
    CitySearchView(
        vm: .init(services: StubServices()), 
        selectedCoordinates: .constant(Coordinate(latitude: 37.564713, longitude: 126.975122)),
        showCitySerachView: .constant(true)
    )
}

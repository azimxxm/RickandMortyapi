//
//  LocationDetailViewModel.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//

import SwiftUI

class LocationDetailViewModel: ObservableObject {
    @Published var location: LocationDM?
    @Published var errorMessage: String?
    
    func getLocationDetail(locationId: Int) {
        APIService.shared.fetchLocationDetail(locationId: locationId) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let location):
                    self?.location = location
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
        }
    }
}

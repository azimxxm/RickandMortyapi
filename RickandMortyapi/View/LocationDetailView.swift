//
//  LocationDetailView.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//
import SwiftUI

struct LocationDetailView: View {
    let locationId: Int
    @StateObject private var viewModel = LocationDetailViewModel()
    var body: some View {
        Group {
            if let location = viewModel.location {
                VStack(alignment: .leading, spacing: 16) {
                    Text(location.name)
                        .font(.largeTitle)
                        .bold()

                    Text("Type: \(location.type)")
                        .font(.headline)

                    Text("Dimension: \(location.dimension)")
                        .font(.subheadline)

                    Text("Residents:")
                        .font(.headline)

                    List(location.residents, id: \.self) { residentURL in
                        Text(residentURL)
                    }
                }
                .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: {  viewModel.getLocationDetail(locationId: locationId)})
        .navigationTitle("Location Details")
    }
}

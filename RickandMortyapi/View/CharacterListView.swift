//
//  CharacterListView.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//


import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterViewModel()
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.characters) { character in
                    NavigationLink {
                        LocationDetailView(locationId: character.item_id)
                    } label: {
                        CharacterCard(character: character)
                    }
                    .onAppear {  viewModel.checkIsLastItemVisible(item: character)}

                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .onAppear {
                viewModel.fetchCharacters()
            }
            .onAppear(perform: viewModel.fetchCharacters)
            .listStyle(.plain)
            .navigationTitle("Rick and Morty")
        }
        .onAppear {
            viewModel.fetchCharacters()
        }
        .networkStatus(isConnected: $networkMonitor.isConnected)

    }
}

#Preview {
    CharacterListView()
}

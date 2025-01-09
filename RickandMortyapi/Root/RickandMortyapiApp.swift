//
//  RickandMortyapiApp.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//

import SwiftUI

@main
struct RickandMortyapiApp: App {
    @StateObject private var networkMonitor = NetworkMonitor.shared
    var body: some Scene {
        WindowGroup {
            CharacterListView()
                .environmentObject(networkMonitor)
                .networkStatus(isConnected: $networkMonitor.isConnected)
        }
    }
}

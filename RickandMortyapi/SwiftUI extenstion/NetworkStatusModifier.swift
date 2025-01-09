//
//  NetworkStatusModifier.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//
import SwiftUI

// MARK: - NetworkStatusModifier
struct NetworkStatusModifier: ViewModifier {
    @Binding var isConnected: Bool

    func body(content: Content) -> some View {
        content.overlay {
            if !isConnected {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "wifi.slash")
                            .foregroundColor(.white)
                        Text("No Internet Connection")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: isConnected)
            }
        }
    }
}

// MARK: - View Extension
extension View {
    func networkStatus(isConnected: Binding<Bool>) -> some View {
        self.modifier(NetworkStatusModifier(isConnected: isConnected))
    }
}

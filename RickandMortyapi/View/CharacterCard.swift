//
//  CharacterCard.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//


import SwiftUI

struct CharacterCard: View {
    let character: CharacterDM
    
    var body: some View {
        HStack {
            CachedImageView(url: character.image)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            Text(character.name)
                .font(.headline)
        }
    }
}

#Preview {
    CharacterCard(
        character: CharacterDM(
            item_id: 1,
            name: "Azimjon",
            image: "image"
        )
    )
}

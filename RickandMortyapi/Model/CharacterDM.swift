//
//  CharacterDM.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//
import SwiftUI

struct CharacterDM: Codable, Identifiable {
    var id = UUID().uuidString
    let item_id: Int
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case item_id = "id"
        case name
        case image
    }
}

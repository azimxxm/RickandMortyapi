//
//  LocationDM.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//
import SwiftUI

struct LocationDM: Codable, Identifiable {
    var id = UUID().uuidString
    let item_id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    
    enum CodingKeys: String, CodingKey {
        case item_id = "id"
        case name
        case type
        case dimension
        case residents
    }
}

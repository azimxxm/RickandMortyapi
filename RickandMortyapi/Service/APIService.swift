//
//  APIService.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//


import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "https://rickandmortyapi.com/api"
    
    func fetchCharacters(page: Int, completion: @escaping (Result<[CharacterDM], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/character?page=\(page)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func fetchLocationDetail(locationId: Int, completion: @escaping (Result<LocationDM, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/location/\(locationId)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let location = try JSONDecoder().decode(LocationDM.self, from: data)
                completion(.success(location))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct APIResponse: Codable {
    let results: [CharacterDM]
}

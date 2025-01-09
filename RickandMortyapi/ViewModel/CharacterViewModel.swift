//
//  CharacterViewModel.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//


import SwiftUI
import Combine

class CharacterViewModel: ObservableObject {
    @Published var characters: [CharacterDM] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var currentPage = 0
    private var canLoadMore = true
    
    func fetchCharacters() {
        guard !isLoading && canLoadMore else { return }
        isLoading = true
        
        APIService.shared.fetchCharacters(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let newCharacters):
                    self?.characters.append(contentsOf: newCharacters)
                    self?.currentPage += 1
                    self?.canLoadMore = !newCharacters.isEmpty
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
    func refreshCharacters() {
        currentPage = 1 // Paginatsiyani boshidan boshlash
        characters = [] // Eski ma'lumotlarni tozalash
        fetchCharacters() // API-dan ma'lumotlarni qayta olish
    }

    
    
    func checkIsLastItemVisible(item: CharacterDM) {
        guard let lastItem = characters.last else { return }
        if item.item_id == lastItem.item_id {  fetchCharacters() }
    }
}

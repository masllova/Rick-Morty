//
//  ViewModel.swift
//  Rick&Morty
//
//  Created by Александра Маслова on 17.08.2023.
//

import Foundation

class ViewModel: ObservableObject {
    let manager = NetworkingManager()
    @Published var personages = [Personage]()
    
    func fetchPersonages() {
        manager.loadPersonages { [weak self] loadedPersonages in
            if let loadedPersonages = loadedPersonages {
                self?.personages = loadedPersonages
                self?.personages.sort { $0.id < $1.id }
            }
        }
    }
}

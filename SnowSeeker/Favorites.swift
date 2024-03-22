//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Leo  on 21.03.24.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private static let key = "Favorites"
    
    init() {
        // load our saved data
        if let data = UserDefaults.standard.data(forKey: Favorites.key) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(data, forKey: Favorites.key)
        }
    }
}


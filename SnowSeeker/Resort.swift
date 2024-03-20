//
//  Resort.swift
//  SnowSeeker
//
//  Created by Leo  on 20.03.24.
//

import Foundation

struct Resort: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}

//
//  Model.swift
//  PassthroughSubject
//
//  Created by Киса Мурлыса on 24.05.2024.
//

import Foundation

struct Good: Identifiable {
    var id = UUID()
    
    var image: String
    var name: String
    var price: Int
}

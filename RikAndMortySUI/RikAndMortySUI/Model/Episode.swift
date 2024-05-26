//
//  Episode.swift
//  RikAndMortySUI
//
//  Created by Киса Мурлыса on 26.05.2024.
//

import Foundation

struct Episodes: Decodable {
    let results: [Episode]
}

struct Episode: Decodable, Hashable {
    /// Наименование серии
    let name: String
    /// Номер серии
    let episode: String
    /// массив картинок
    let characters: [String]
}

struct Character: Decodable {
    let image: String
}

struct CurrentEpisode {
    let name: String
    let number: String
    let image: String
}

//
//  Episode.swift
//  RikAndMortySUI
//
//  Created by Киса Мурлыса on 26.05.2024.
//

import Foundation

/// Модель эпизодов
struct Episodes: Decodable {
    /// Массив эпизодов
    let results: [Episode]
}

/// Модель конкретного эпизода
struct Episode: Decodable, Hashable {
    /// Наименование серии
    let name: String
    /// Номер серии
    let episode: String
    /// массив картинок
    let characters: [String]
}

/// Модель серии с картинкой
struct Character: Decodable {
    /// Ссылка на картинку
    let image: String
}

/// Конкретный полученный эпизод
struct CurrentEpisode {
    /// Наименование серии
    let name: String
    /// Номер серии
    let number: String
    /// Ссылка на получение картинки серии
    let image: String
}

//
//  State.swift
//  RikAndMortySUI

import Foundation

/// Состояние Эзагрузки
enum StateView {
    /// В процессе загрузки
    case loading
    /// Ошибка запроса
    case error
    /// Загружено
    case loaded
}

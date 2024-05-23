//
//  ErrorType.swift
//  Failpublisher

import Foundation

enum InvalidNumberError: String, Error, Identifiable {
    var id: String { rawValue }
    
    case  notNumber = "Введенное значение не является числом"
}

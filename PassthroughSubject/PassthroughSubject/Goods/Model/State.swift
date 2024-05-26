//
//  State.swift
//  PassthroughSubject

import Foundation

enum StateView<Model> {
    case connecting(_ time: Model)
    case download(_ time: Model)
    case loaded
}

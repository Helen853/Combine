//
//  ViewModel.swift
//  Numbers
//
//  Created by Киса Мурлыса on 22.05.2024.
//

import Foundation
import Combine

final class NumbersViewModel: ObservableObject {
    var number = CurrentValueSubject<String, Never>(" ")
    var visibleText = CurrentValueSubject<String, Never>(" ")
    var randomNumber = CurrentValueSubject<Int, Never>(Int.random(in: 1 ... 100))
    var cancellable: Set<AnyCancellable> = []
    
    init() {
        number
            .map { [unowned self] newValue -> String in
                switch newValue {
                case  _ where Int(newValue) == randomNumber.value:
                    return "Вы угадали число"
                case  _ where Int(newValue) ?? 0 > randomNumber.value:
                    return "Введенное число больше загаданного"
                case  _ where Int(newValue) ?? 0 < randomNumber.value:
                    return "Введенное число меньше загаданного“"
                default:
                    return " "
                }
            }
            .delay(for: 0.8, scheduler: DispatchQueue.main)
            .sink { [unowned self] value in
                visibleText.value = value
                objectWillChange.send()
            }
            .store(in: &cancellable)
    }
    
    func finish() {
        visibleText.value = "Игра окончена! \n Загаданное чиcло - \(randomNumber.value)"
        objectWillChange.send()
        cancellable.removeAll()
    }
}

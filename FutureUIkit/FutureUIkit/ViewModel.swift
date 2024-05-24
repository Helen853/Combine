//
//  ViewModel.swift
//  FutureUIkit

import Foundation
import Combine

final class NumberViewModel: ObservableObject {
    @Published var inputText: String?
    @Published var textAfterCheck: String?
    
    var cancelable: AnyCancellable?

    func fetch() {
        cancelable = checkNumber()
            .sink { complition in
                print(complition)
            } receiveValue: { [unowned self] value in
                guard let number = inputText else { return}
                textAfterCheck = "\(number) - \(value)"
            }
    }
    
    func update() {
        objectWillChange.send()
    }
    
    private func checkNumber() -> AnyPublisher<String, Error>  {
        Future { promise in
            guard let number = Int(self.inputText ?? "0") else { return }
            if number > 1 && !(2..<number).contains(where: { number % $0 == 0 }) {
                promise(.success("Число не простое"))
            } else {
                promise(.success("Число простое"))
            }
        }
        .eraseToAnyPublisher()
    }
}

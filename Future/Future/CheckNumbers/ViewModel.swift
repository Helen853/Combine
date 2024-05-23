//
//  ViewModel.swift
//  Future

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
                textAfterCheck = value
            }
    }
    
    func update() {
        objectWillChange.send()
    }
    
    private func checkNumber() -> AnyPublisher<String, Error>  {
        Future { promise in
            if (Int(self.inputText ?? "0") ?? 0) % 2 == 0 || (Int(self.inputText ?? "0") ?? 0) % 3 == 0 {
                promise(.success("Число не простое"))
            } else {
                promise(.success("Число простое"))
            }
        }
        .eraseToAnyPublisher()
    }
}

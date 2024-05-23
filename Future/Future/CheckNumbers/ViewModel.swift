//
//  ViewModel.swift
//  Future

import Foundation
import Combine

final class NumberViewModel: ObservableObject {
    @Published var inputText = ""
    @Published var textAfterCheck = ""
    
    var cancelable: AnyCancellable?

    func fetch() {
        cancelable = checkNumber()
            .sink { complition in
                print(complition)
            } receiveValue: { [unowned self] value in
                textAfterCheck = value
            }
    }
    
    private func checkNumber() -> AnyPublisher<String, Error>  {
        Future { promise in
            if (Int(self.inputText) ?? 0) % 2 == 0 {
                promise(.success("Число простое"))
            } else {
                promise(.success("Число не простое"))
            }
        }
        .eraseToAnyPublisher()
    }
}

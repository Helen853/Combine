//
//  ViewModel.swift
//  Failpublisher


import Foundation
import Combine

final class InputViewModel: ObservableObject {
    @Published var error: InvalidNumberError?
    
    var text = CurrentValueSubject<[String?], Never>([])
    var inputText = CurrentValueSubject<String?, Never>(nil)
    var textForView = CurrentValueSubject<[String], Never>(["111"])
        
    var cancellable: Set<AnyCancellable> = []
    
    func update() {
        error = nil
        objectWillChange.send()
    }
    
    func remove() {
        textForView.value.removeAll()
        text.value.removeAll()
        objectWillChange.send()
    }
    
    func save() {
        _ = validationNumber(number: Int(inputText.value ?? "-1") ?? -1 )
            .sink(receiveCompletion: { [unowned self] complition in
                switch complition {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            }, receiveValue: { [unowned self] value in
                self.inputText.value = String(value)
            })
    }
    
    private func addText() {
        text.value.append(inputText.value)
        _ = text
            .value
            .publisher
            .flatMap { item -> AnyPublisher<String, Never> in
                if let item {
                    return Just(item)
                        .eraseToAnyPublisher()
                } else {
                    return Empty(completeImmediately: true)
                        .eraseToAnyPublisher()
                }
            }
            .sink { [unowned self] item in
                textForView.value.append(item)
                text.value.removeAll()
                inputText.value = nil
                objectWillChange.send()
            }
    }
    
    private func validationNumber(number: Int) -> AnyPublisher<Int, InvalidNumberError> {
        if number < 0 {
            return Fail(error: InvalidNumberError.notNumber)
                .eraseToAnyPublisher()
        } else {
            addText()
            update()
            return Just(number)
                .setFailureType(to: InvalidNumberError.self)
                .eraseToAnyPublisher()
        }
    }
    
}

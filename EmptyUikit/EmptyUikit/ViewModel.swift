//
//  ViewModel.swift
//  EmptyUIkit

import Foundation

final class InputViewModel: ObservableObject {
    @Published var text = CurrentValueSubject<[String?], Never>([])
    var inputText = CurrentValueSubject<String?, Never>(nil)
    var textForView = CurrentValueSubject<[String], Never>(["RM4"])
        
    var cancellable: Set<AnyCancellable> = []
    
    func addText() {
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
                       print(item)
                       textForView.value.append(item)
                       text.value.removeAll()
                       inputText.value = nil
                       objectWillChange.send()
                   }
    }
    
    func update() {
        objectWillChange.send()
    }
    
    func remove() {
        textForView.value.removeAll()
        text.value.removeAll()
        objectWillChange.send()
    }
    
}

//
//  ViewModel.swift
//  Just
//
//  Created by Киса Мурлыса on 23.05.2024.
//

import Foundation
import Combine

final class FructsViewModel: ObservableObject {
    @Published var dataToView: [String] = []
    
    private var fructs = ["Яблоко (начальный)", "Банан (начальный)", "Апельсин (начальный)"]
    private var addedFructs = ["Киви", "Груша", "Лимон"]
    
    func fetch() {
        _ = fructs.publisher
            .sink(receiveCompletion: { complition in
                print(complition)
            }, receiveValue: { [unowned self] value in
                dataToView.append(value)
                print(value)
            })
    }
    
    func addFruct() {
        _ = addedFructs.publisher
            .last()
            .sink(receiveValue: { [unowned self] value in
                dataToView.append(value)
                addedFructs.removeLast()
            })
    }
    
    func removeFruct() {
        let removeFruct = dataToView.removeLast()
        addedFructs.append(removeFruct)
    }
    
}

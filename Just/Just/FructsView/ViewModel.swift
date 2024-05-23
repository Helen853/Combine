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
    
    var fructs = ["Яблоко", "Банан", "Апельсин", "Киви", "Груша"]
    
    func fetch() {
        _ = fructs.publisher
            .sink(receiveCompletion: { complition in
                print(complition)
            }, receiveValue: { [unowned self] value in
                dataToView.append(value)
                print(value)
            })
    }
    
}

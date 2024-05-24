//
//  ViewModel.swift
//  PassthroughSubject
//
//  Created by Киса Мурлыса on 24.05.2024.
//

import Foundation
import Combine

final class GoodViewModel: ObservableObject {
    @Published var loadedGood: [Good] = []
    @Published var state: StateView = .connecting
    let verify = PassthroughSubject<String, Never>()
    
    var cancellable: AnyCancellable?
    var timerCancellable: AnyCancellable?
    
    @Published var goods: [Good] = [
        .init(image: "apple.logo", name: "Яблоко", price: 100),
        .init(image: "applescript", name: "Блокнот", price: 80),
        .init(image: "applewatch", name: "Часы", price: 2000),
        .init(image: "pencil.tip.crop.circle", name: "Ручка", price: 43),
        .init(image: "photo.circle", name: "Картина", price: 1009),
        .init(image: "speaker.2.fill", name: "Микрофон", price: 345),
        .init(image: "book.circle", name: "Книга", price: 651)
    ]
    
//    init() {
//        bind()
//    }
    
//    func bind() {
//        cancellable = verify
//            .sink(receiveValue: { [unowned self] value in
//                if !value.isEmpty {
//                    state = .data(value)
//                } else {
//                    state = .error(NSError(domain: "Error", code: 400))
//                }
//            })
//    }
    
    func start() {
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "00:ss"
        
        timerCancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [unowned self] datum in
                verify.send(timeFormat.string(from: datum))
            })
    }
    
    func fetch() {
        _ = goods.publisher
            .sink(receiveCompletion: { complition in
                print(complition)
            }, receiveValue: { [unowned self] value in
                loadedGood.append(value)
            })
    }
        
}

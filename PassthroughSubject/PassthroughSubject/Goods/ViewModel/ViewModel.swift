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
    @Published var state: StateView<String> = .connecting("")
    var startDate = Date.now
    var currentTime = 0
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
    
    func start() {
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        timerCancellable =  timer
            .sink(receiveValue: { [unowned self] _ in
                currentTime += 1
                verify.send(String("00:0\(currentTime)"))
            })
        fetch()
        bind()
    }
    
    private func bind() {
        cancellable = verify
            .sink(receiveValue: { [unowned self] value in
                if !value.isEmpty {
                    state = .connecting(value)
                    updateState(value: value)
                } else {
                    state = .loaded
                }
            })
    }
    
    private func fetch() {
        _ = goods.publisher
            .filter { $0.price >= 100 }
            .sink { self.loadedGood.append($0) }
    }
    
    private func updateState(value: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.state = .download(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.timerCancellable?.cancel()
                self.state = .loaded
            }
        }
    }
}

//
//  ViewModel.swift
//  Basket


import Foundation
import Combine

final class BasketViewModel: ObservableObject {
    @Published var goods: [Good] = [
        .init(name: "Хлеб", price: 40),
        .init(name: "Молоко", price: 98),
        .init(name: "Капуста", price: 123),
        .init(name: "Сосиски", price: 250),
        .init(name: "Икра", price: 1807)
    ]
    
    @Published var addedGoods: [Good] = []
    @Published var addedGood: Good?
    @Published var removeGood: Good?
    @Published var allSumm = 0
    
    private var goodsCancellables: Set<AnyCancellable> = []
    
    init() {
        $addedGood
            .filter {$0?.price ?? 0 <= 1000}
            .sink(receiveValue: { good in
                guard let good else { return }
                self.addedGoods.append(good)
            })
            .store(in: &goodsCancellables)
        
        $removeGood
            .sink(receiveValue: { good in
                guard let index = self.addedGoods.firstIndex(where:  {$0.name == good?.name}) else { return }
                self.addedGoods.remove(at: index)
            })
            .store(in: &goodsCancellables)
        
        $addedGoods
            .map { $0.reduce(0) {$0 + $1.price} }
            .scan(100) { allSumm, price in
                100 + price
            }
            .assign(to: \.allSumm, on: self)
    }
    
    func removeGood(index: Int) {
        removeGood = goods[index]
        if goods[index].price < 1000 {
            allSumm -= goods[index].price
        }
        
    }
    
    func addGood(index: Int) {
        addedGood = goods[index]
        if goods[index].price < 1000 {
            allSumm += goods[index].price
        }
    }
    
    func removeAll() {
        addedGoods.removeAll()
        allSumm = 100
    }
}

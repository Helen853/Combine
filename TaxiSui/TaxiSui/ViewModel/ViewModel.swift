//
//  ViewModel.swift
//  TaxiSui

import Foundation
import Combine

final class TaxiViewModel: ObservableObject {
    @Published var data = ""
    @Published var status = ""
    
    private var anyCancellable: AnyCancellable?
    
    init() {
        anyCancellable = $data
            .map { [unowned self] value -> String in
                status = "Сделайте заказ"
                return value
            }
            .delay(for: 7, scheduler: DispatchQueue.main)
            .sink {  [unowned self] value in
                self.status = value
            }
    }
    
    func refresh() {
        data = " "
        anyCancellable = $data
            .map { [unowned self] value -> String in
                status = "Идет поиск..."
                return value
            }
            .delay(for: 7, scheduler: DispatchQueue.main)
            .sink {  [unowned self] value in
                self.data = "Водитель будет через 10 мин."
                self.status = "Поиск окончен"

            }
    }
    
    func cancel() {
        data = " "
        anyCancellable = $data
            .map { [unowned self] value -> String in
                status = "Отмена заказа..."
                return value
            }
            .delay(for: 1, scheduler: DispatchQueue.main)
            .sink {  [unowned self] value in
                self.data = "Заказ отменен"
                self.status = " "
                
            }
    }
}

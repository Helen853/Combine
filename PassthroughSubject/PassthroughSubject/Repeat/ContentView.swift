//
//  ContentView.swift
//  PassthroughSubject
//
//  Created by Киса Мурлыса on 24.05.2024.
//

import SwiftUI
import Combine

enum ViewState<Model> {
    case loading
    case data(_ data: Model)
    case error(_ error: Error)
}

struct ContentView: View {
    
    @StateObject var viewModel = SubjectViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                Button("Start") {
                    viewModel.verify.send("00:00")
                    viewModel.start()
                }
            case .data(let time):
                Text(time)
                    .font(.title)
                    .foregroundColor(.green)
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
    }
}

class SubjectViewModel: ObservableObject {
    @Published var state: ViewState<String> = .loading
    let verify = PassthroughSubject<String, Never>()
    
    var cancellable: AnyCancellable?
    var timerCancellable: AnyCancellable?
    
    init() {
        bind()
    }
    
    func bind() {
        cancellable = verify
            .sink(receiveValue: { [unowned self] value in
                if !value.isEmpty {
                    state = .data(value)
                } else {
                    state = .error(NSError(domain: "Error", code: 400))
                }
            })
    }
    
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

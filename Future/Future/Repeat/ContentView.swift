//
//  ContentView.swift
//  Future
//
//  Created by Киса Мурлыса on 23.05.2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = FuturePublisherViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.firstResult)
            
            Button {
                viewModel.fetch()
            } label: {
                Text("Запуск")
            }
            
            Text(viewModel.secondResult)

        }
        .onAppear {
            viewModel.fetch()
        }
        .padding()
    }
}

class FuturePublisherViewModel: ObservableObject {
    @Published var firstResult = ""
    @Published var secondResult = ""
    var cancelable: AnyCancellable?
    
//    let futurePublisher = Deferred {
//        Future<String, Never> { promise in
//            promise(.success("Future Publisher сработал"))
//            print("Future сработало")
//        }
//    }
    
    func fetch() {
        guard let url = URL(string: "") else { return }
        cancelable = createFetch(url: url)
            .sink { complition in
                print(complition)
            } receiveValue: { [unowned self] value in
                firstResult = value ?? ""
            }

        
    }
    
//    func runAgain() {
//        futurePublisher
//            .assign(to: &$secondResult)
//    }
    
//    func createFetch(url: URL, complition: @escaping (Result<String, Error>)->()) {
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                complition(.failure(error))
//                return
//            }
//
//            complition(.success(response?.url?.absoluteString ?? ""))
//
//        }
//        task.resume()
//    }
    
    func createFetch(url: URL) -> AnyPublisher<String, Error> {
        
        Future { promise in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                promise(.success(response?.url?.absoluteString ?? ""))
                
            }
            task.resume()
        }
        .eraseToAnyPublisher()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

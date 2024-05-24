//
//  ContentView.swift
//  Just
//
//  Created by Киса Мурлыса on 23.05.2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = JustViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .bold()
            Form {
                Section(header: Text("uchastniki")) {
                    List(viewModel.dataToView, id: \.self) { item in
                       Text(item)
                    }
                }
            }
        }.onAppear {
            viewModel.fetch()
        }
        .padding()
    }
}

class JustViewModel: ObservableObject {
    @Published var title = ""
    @Published var dataToView: [String] = []
    
    var name = ["Mark", "Tom", "Pol"]
    var text = "hello"
    
    func fetch() {
        _ = name.publisher
            .sink(receiveCompletion: { complition in
                print(complition)
            }, receiveValue: { [unowned self] value in
                dataToView.append(value)
                print(value)
            })
        if name.count > 0 {
            Just(name[1])
                .map { item in
                    item.uppercased()
                }
                .assign(to: &$title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

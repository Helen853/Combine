//
//  FructsView.swift
//  Just

import SwiftUI

struct FructsView: View {
    @StateObject var viewModel = FructsViewModel()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Фрукты")) {
                    List(viewModel.dataToView, id: \.self) { item in
                       Text(item)
                    }
                }
            }
            
            HStack {
                Button("Добавить фрукт") {
                    print("f")
                }
                Spacer()
                Button("Удалить фрукт") {
                    print("f")
                }
            }.padding()
            
        }.onAppear {
            viewModel.fetch()
        }
        .padding()
    }
}

struct FructsView_Previews: PreviewProvider {
    static var previews: some View {
        FructsView()
    }
}

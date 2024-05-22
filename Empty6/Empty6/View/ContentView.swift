//
//  ContentView.swift
//  Empty6
//
//  Created by Киса Мурлыса on 22.05.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = InputViewModel()
    var body: some View {
        VStack {
            TextField("Введите строку", text: Binding(get: {
                if let text = viewModel.inputText.value {
                    return text
                } else {
                    return ""
                }
            }, set: { newValue in
                viewModel.update()
                if newValue == "" {
                    viewModel.inputText.value = nil
                } else {
                    viewModel.inputText.value = newValue
                }
            }))
            .textFieldStyle(.roundedBorder)
            HStack {
                Button {
                    viewModel.addText()
                } label: {
                    Text("Добавить")
                        .foregroundColor(.gray)
                }
                Spacer()
                Button {
                    viewModel.remove()
                } label: {
                    Text("Очистить список")
                }
            }
            List(viewModel.textForView.value, id: \.self) { text in
                Text(text)
            }
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

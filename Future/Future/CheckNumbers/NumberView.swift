//
//  NumberView.swift
//  Future

import SwiftUI

struct NumberView: View {
    @StateObject var viewModel = NumberViewModel()
    
    var body: some View {
        VStack {
            TextField("Введите число", text: $viewModel.inputText)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            Button("Проверить простоту числа") {
                viewModel.fetch()
            }
            Text("\(viewModel.inputText)  \(viewModel.textAfterCheck)")
                .foregroundColor(.green)

        }
        .padding()
    }
}

struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        NumberView()
    }
}


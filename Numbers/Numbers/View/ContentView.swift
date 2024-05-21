//
//  ContentView.swift
//  Numbers
//
//  Created by Киса Мурлыса on 21.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = NumbersViewModel()
  
    
    var body: some View {
        ZStack {
            Color("graund")
                .ignoresSafeArea(.all)
            VStack {
                headerView
                Spacer()
                
                Text("Введите число от 1 до 100")
                    .foregroundColor(.yellow)
                    .font(.system(size: 20, weight: .bold))
                numberTextField
                
                Text(viewModel.visibleText.value)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
        
                Spacer()
                finishButton
                Spacer()
            }
        }
    }
    
    private var headerView: some View {
        Text("Угадай число")
            .foregroundColor(.white)
            .font(.system(size: 30, weight: .medium))
    }
    
    private var numberTextField: some View {
        TextField("0", text: $viewModel.number.value.max(3))
            .frame(width: 100, height: 80)
            .font(.system(size: 40))
            .background(.white)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.yellow, lineWidth: 9)
            })
            .cornerRadius(30)
            .keyboardType(.numberPad)
    }
    
    private var finishButton: some View {
        Button {
            viewModel.finish()
        } label: {
            Text("Завершить игру")
                .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.yellow)
                    .frame(width: 200, height: 50)
                )
                .foregroundColor(.purple)
                .font(.system(size: 20, weight: .bold))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

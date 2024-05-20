//
//  ContentView.swift
//  CombineTextField

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = AuthorizationViewModel()
    
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea(.all)
            VStack {
                Text("Authorization")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                TextField("Name", text: $viewModel.name)
                    .frame(height: 50)
                    .background(.white)
                    .cornerRadius(15)
                Text(viewModel.validationName)
                    .foregroundColor(.red)
                    .font(.system(size: 15))
                TextField("SurName", text: $viewModel.surName)
                    .frame(height: 50)
                    .background(.white)
                    .cornerRadius(15)
                Text(viewModel.validationSurName)
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                
                Text("Войти")
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(12)
                
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

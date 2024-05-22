//
//  ContentView.swift
//  TaxiSui


import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = TaxiViewModel()
    
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer ( )
                Text (viewModel.data)
                    .font (.title)
                    .foregroundColor(.white)
                Text(viewModel.status)
                    .foregroundColor(.black)
                Spacer ( )
                Button {
                    viewModel.cancel()
                } label: {
                    Text ("Отменить заказ")
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.red)
                        .cornerRadius (8)
                        .opacity (viewModel.status == "Поиск окончен" ? 1.0 : 0.0)
                }
                
                Button {
                    viewModel.refresh()
                } label: {
                    Text ("Вызвать такси")
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

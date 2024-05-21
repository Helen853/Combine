//
//  ContentView.swift
//  Basket

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = BasketViewModel()
    
    var body: some View {
        ZStack {
            Color(uiColor: .lightGray)
                .ignoresSafeArea(.all)
            VStack {
                VStack {
                    ForEach(0..<viewModel.goods.count) { good in
                        makeGood(index: good)
                    }
                }.background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 350, height: 400)
                    )
                Spacer()
                    .frame(height: 50)
                
                List {
                    Text("Корзина")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                    ForEach(viewModel.addedGoods, id: \.id) { good in
                        makeCell(item: good)
                    }
                    Text("Итого: \(viewModel.allSumm)")
                    removeButton
                }
                
                
            }
        }
    }
    
    private var removeButton: some View {
        Button {
            viewModel.removeAll()
        } label: {
            Text("Удалить все")
        }

    }
    
    func makeGood(index: Int) -> some View {
        HStack(spacing: 40) {
            Button {
                viewModel.addGood(index: index)
            } label: {
                Text("+")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold))
                    .background(
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 70, height: 40)
                        .foregroundColor(.green)
                    )
            }
            
            Text("\(viewModel.goods[index].name) - \(viewModel.goods[index].price) руб.")
                .frame(width: 165, height: 40)
                .foregroundColor(.blue)
                .font(.system(size: 15, weight: .bold))
            
            Button {
                viewModel.removeGood(index: index)
            } label: {
                Text("-")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold))
                    .background(
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 70, height: 40)
                        .foregroundColor(.red)
                    )
            }

        }.padding(.horizontal, 10)
    }
    
    private func makeCell(item: Good) -> some View {
        HStack {
            Text(item.name)
                .frame(width: 180, height: 50, alignment: .leading)
            Text("\(item.price) руб.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

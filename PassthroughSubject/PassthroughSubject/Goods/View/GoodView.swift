//
//  GoodView.swift
//  PassthroughSubject

import SwiftUI

struct GoodView: View {
    
    @StateObject var viewModel = GoodViewModel()
    @State var isLoad = false
    
    var body: some View {
        VStack {
            Text("timer left")
            Spacer()
            makeView()
            Spacer()
            
            Button("Start") {
                viewModel.fetch()
                viewModel.start()
                isLoad.toggle()
            }
        }
    }
    
    private func makeGoodCell(good: Good) -> some View {
        HStack {
            Image(systemName: good.image)
            Text(good.name)
            Text("\(good.price) руб")
        }
    }
    
    private func makeView() -> some View {
        Group {
            switch viewModel.state {
            case .connecting:
                ConnectView()
            case .download:
                DownloadView()
            case .loaded:
                List(viewModel.goods, id: \.id) { item in
                    makeGoodCell(good: item)
                }
            }
        }.isVisible(isVisible: isLoad)
    }
}

struct GoodView_Previews: PreviewProvider {
    static var previews: some View {
        GoodView()
    }
}


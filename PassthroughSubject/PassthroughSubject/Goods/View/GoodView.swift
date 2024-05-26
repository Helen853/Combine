//
//  GoodView.swift
//  PassthroughSubject

import SwiftUI

struct GoodView: View {
    
    @StateObject var viewModel = GoodViewModel()
    @State var isLoad = false
    @State var isLoadText = true
    
    var body: some View {
        VStack {
            Text("timer left    ").isVisible(isVisible: isLoadText)
            makeView()
            Spacer()
            
            Button("Start") {
                viewModel.verify.send("00:00")
                viewModel.start()
                isLoad.toggle()
                isLoadText.toggle()
            }
        }
    }
    
    private func makeGoodCell(good: Good) -> some View {
        HStack {
            Image(systemName: good.image)
            Text(good.name)
            Spacer()
            Text("\(good.price) руб")
        }
    }
    
    private func makeView() -> some View {
        VStack {
            switch viewModel.state {
            case .connecting(let time):
                Text("timer left \(time)")
                Spacer()
                ConnectView()
                Spacer()
            case .download(let time):
                Text("timer left \(time)")
                DownloadView()
            case .loaded:
                Text("timer left")
                List(viewModel.loadedGood, id: \.id) { item in
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


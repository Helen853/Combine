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

struct IsVisibleModifier: ViewModifier{
    var isVisible: Bool
    var transition: AnyTransition

    func body(content: Content) -> some View {
        ZStack{
            if isVisible{
                content
                    .transition(transition)
            }
        }
    }
}

extension View {
    func isVisible(
        isVisible : Bool,
        transition : AnyTransition = .scale
    ) -> some View{
        modifier(
            IsVisibleModifier(
                isVisible: isVisible,
                transition: transition
            )
        )
    }
}

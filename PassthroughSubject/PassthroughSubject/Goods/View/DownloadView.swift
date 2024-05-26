//
//  DownloadView.swift
//  PassthroughSubject
//
//  Created by Киса Мурлыса on 24.05.2024.
//

import SwiftUI

struct DownloadView: View {
    @State var isShow = [false, false, false]
    @StateObject var viewModel = GoodViewModel()
    
    var body: some View {
        VStack {
            Text("Download")
                .foregroundColor(.blue)
                .font(.title)
            List {
                loadView
                loadView
                loadView
                loadView
                loadView
//                ForEach(0..<viewModel.loadedGood.count) { index in
//                    loadView
//                }
                
            }
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                withAnimation(.linear(duration: 0.5)) {
                    isShow[0] = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                withAnimation(.linear(duration: 0.5)) {
                    isShow[1] = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.linear(duration: 0.5)) {
                    isShow[2] = true
                }
            }
        }
    }
    
    private var loadView: some View {
        HStack(spacing: 20) {
                Rectangle()
                    .fill(Color(uiColor: .lightGray))
                    .frame(width: 20, height: 20)
                    .opacity(isShow[0] ? 1 : 0)
                    .shadow(color: .cyan, radius: 5)
                Rectangle()
                    .fill(Color(uiColor: .lightGray))
                    .frame(width: 200, height: 20)
                    .opacity(isShow[1] ? 1 : 0)
                    .shadow(color: .cyan, radius: 5)
                Rectangle()
                    .fill(Color(uiColor: .lightGray))
                    .frame(width: 50, height: 20)
                    .opacity(isShow[2] ? 1 : 0)
                    .shadow(color: .cyan, radius: 5)
        }
    }
    
    private func makeShimmer(index: Int) -> some View {
        HStack {
            Rectangle()
                .fill(Color(uiColor: .lightGray))
                .frame(width: 20, height: 20)
                .opacity(isShow[0] ? 1 : 0)
                .shadow(color: .cyan, radius: 5)
            Rectangle()
                .fill(Color(uiColor: .lightGray))
                .frame(width: 170, height: 20)
                .opacity(isShow[1] ? 1 : 0)
                .shadow(color: .cyan, radius: 5)
            Rectangle()
                .fill(Color(uiColor: .lightGray))
                .frame(width: 50, height: 20)
                .opacity(isShow[2] ? 1 : 0)
                .shadow(color: .cyan, radius: 5)
        }
    }
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}

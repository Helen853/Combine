//
//  DownloadView.swift
//  PassthroughSubject
//
//  Created by Киса Мурлыса on 24.05.2024.
//

import SwiftUI

struct DownloadView: View {
    @State var isShow = [false, false, false]
    
    var body: some View {
        VStack {
            Text("Download")
                .foregroundColor(.blue)
                .font(.title)
            List {
                loadView
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
            ForEach(0..<isShow.count) { index in
                Rectangle()
                    .fill(.blue)
                    .frame(width: 10, height: 10)
                    .opacity(isShow[index] ? 1 : 0)
                    .shadow(color: .cyan, radius: 5)
            }
        }
    }
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}

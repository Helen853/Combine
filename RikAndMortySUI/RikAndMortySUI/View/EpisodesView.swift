//
//  EpisodesView.swift
//  RikAndMortySUI
//
//  Created by Киса Мурлыса on 26.05.2024.
//

import SwiftUI

struct EpisodesView: View {
    @StateObject var viewModel = EpisodesViewModel()
    
    var body: some View {
        VStack {
            Image("title")
            Spacer()
            ScrollView {
                ForEach(viewModel.currentEpisodes, id: \.name) { episode in
                    makeCell(episode: episode)
                    }
                }
        }.onAppear {
            viewModel.fetch()
        }
    }
    
    private func makeCell(episode: CurrentEpisode) -> some View {
            ZStack {
            Rectangle()
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.86), radius: 2, y: 2)
                .blur(radius: 1)
                .frame(width: 311, height: 357)
            VStack {

                AsyncImage(url: URL(string: episode.image)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 312, height: 232)
                    case .failure(_):
                        Text("error")
                    case .empty:
                        Text("Empty")
                    @unknown default:
                        fatalError()
                    }
                }

                Text(episode.name)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 279, height: 30, alignment: .leading)
               makeBottomCell(episode: episode)
            }.frame(width: 311, height: 357)
        }.padding()
    }
    
    
    private func makeBottomCell(episode: CurrentEpisode) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 311, height: 70)
                .foregroundColor(Color("graund"))
            HStack {
                Image("Play")
                    .frame(width: 32.88, height: 34.08)
                Text("\(episode.name) | \(episode.number)")
                    .font(.system(size: 16))
                    .frame(width: 160, height: 22, alignment: .leading)
                Spacer()
                Image(systemName: "heart")
                    .resizable()
                    .foregroundColor(Color("heartColor"))
                    .frame(width: 35.88, height: 29.99)
            }.padding(.horizontal, 15)
        }
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView()
    }
}


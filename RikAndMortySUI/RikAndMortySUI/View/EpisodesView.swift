//
//  EpisodesView.swift
//  RikAndMortySUI

import SwiftUI

struct EpisodesView: View {
    @StateObject var viewModel = EpisodesViewModel()
    @State var isShowAlert = true
    
    var body: some View {
        VStack {
            Image("title")
            Spacer()
            switch viewModel.state {
            case .loading:
                LoadView()
            case .error:
                errorAlert
            case .loaded:
                ScrollView {
                    ForEach(viewModel.currentEpisodes, id: \.name) { episode in
                        makeCell(episode: episode)
                    }
                }
            }
            Spacer()
            
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
                        Text(" ")
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
    
    private var errorAlert: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.green)
                .frame(width: 320, height: 100)
            VStack {
                Text("Упс! Что-то пошло не так \n Повторите снова")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                Divider()
                    .frame(width: 320, height: 2)
                    .foregroundColor(.white)
                Button("Ok") {
                    isShowAlert = false
                    viewModel.state = .loading
                    viewModel.fetch()
                }
            }
        }.opacity(isShowAlert ? 1 : 0)
    }
    
    private func makeBottomCell(episode: CurrentEpisode) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 311, height: 70)
                .foregroundColor(Color("graund"))
            HStack {
                Image("Play")
                    .frame(width: 32.88, height: 34.08)
                Text("\(episode.name) ")
                Text("| \(episode.number)")
                    .frame(width: 75, height: 22, alignment: .leading)
                Spacer()
                Image(systemName: "heart")
                    .resizable()
                    .foregroundColor(Color("heartColor"))
                    .frame(width: 35.88, height: 29.99)
            }.padding(.horizontal, 15)
                .font(.system(size: 16))
        }
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView()
    }
}


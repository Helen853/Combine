//
//  EpisodesViewModel.swift
//  RikAndMortySUI
//
//  Created by Киса Мурлыса on 26.05.2024.
//

import SwiftUI
import Combine

class EpisodesViewModel: ObservableObject {
    @Published var dataToView: [Episode] = []
    @Published var alertError: ErrorForAlert?
    @Published var currentEpisodes: [CurrentEpisode] = []
    var cansellabe: Set<AnyCancellable> = []
    
    
    func fetch() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Episodes.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { complition in
                if case .failure(let error) = complition {
                    print(error.localizedDescription)
                }
            } receiveValue: { [unowned self] episode in
                dataToView = episode.results
                for episode in dataToView {
                    loadUrlImage(episode: episode)
                }
            }
            .store(in: &cansellabe)
    }
    
    func loadUrlImage(episode: Episode) {
        guard let url = URL(string: episode.characters.randomElement() ?? "") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Character.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { complition in
                if case .failure(let error) = complition {
                    print(error.localizedDescription)
                }
            } receiveValue: { [unowned self] url in
                currentEpisodes.append(.init(name: episode.name, number: episode.episode, image: url.image))
            }
            .store(in: &cansellabe)
    }
}

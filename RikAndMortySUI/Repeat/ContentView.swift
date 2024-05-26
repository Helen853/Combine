//
//  ContentView.swift
//  RikAndMortySUI
//
//  Created by Киса Мурлыса on 26.05.2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = URLSessionViewModel()
    var body: some View {
        VStack(spacing: 20) {
            List(viewModel.dataToView, id: \.title) { post in
                Text(post.title)
                    .font(.title)
                viewModel.avatarImage
                Text(post.body)
                    .font(.caption2)
                
            }
        }.onAppear {
            viewModel.fetch()
            viewModel.loadImage()
        }
        
    }
}
struct ErrorForAlert: Error, Identifiable {
    var id = UUID()
    
    let title = "Errorr"
    var message = "Try Again"
}

struct Post: Decodable {
    let title: String
    let body: String
}

class URLSessionViewModel: ObservableObject {
    @Published var avatarImage: Image?
    @Published var alertError: ErrorForAlert?
    @Published var dataToView: [Post] = []
    var cansellabe: Set<AnyCancellable> = []
    
    func fetch() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { complition in
                if case .failure(let error) = complition {
                    print(error.localizedDescription)
                }
            } receiveValue: { [unowned self] posts in
                dataToView = posts
            }
            .store(in: &cansellabe)

    }
    
    func loadImage() {
        guard let url = URL(string: "https://via.placeholder.com/600/d32776%7C") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .tryMap { data in
                guard let uiImage = UIImage(data: data) else {
                    throw  ErrorForAlert(message: "No Image")
                }
                return Image(uiImage: uiImage)
            }
            .receive(on: RunLoop.main)
            .replaceError(with: Image(systemName: "eye"))
            .sink { [unowned self] image in
                avatarImage = image
            }
            .store(in: &cansellabe)

    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

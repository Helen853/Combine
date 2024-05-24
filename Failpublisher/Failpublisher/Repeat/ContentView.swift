//
//  ContentView.swift
//  Failpublisher


import SwiftUI
import Combine

struct FailPublisherView: View {
    @StateObject var viewModel = FailPublisherViewModel()
    
    var body: some View {
        VStack {
            Text ("\(viewModel.age)")
                .font(.title)
                .foregroundColor(.gray)
                .padding()
            
            TextField("Введите возраст", text: $viewModel.text)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Save") {
                viewModel.save()
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.rawValue))
            }
            
        }
    }
}
enum InvalidError: String, Error, Identifiable {
    
    var id: String { rawValue }
    
    case zero = "Value not will be zero"
    case moreHundred = "Value not will be hindred"
}

class FailPublisherViewModel: ObservableObject {
    @Published var text = ""
    @Published var age = 0
    @Published var error: InvalidError?
    
    func save() {
        _ = validationAge(age: Int(text) ?? -1)
            .sink(receiveCompletion: { [unowned self] complition in
                switch complition {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            }, receiveValue: { [unowned self] value in
                self.age = value
            })
    }
    
    func validationAge(age: Int) -> AnyPublisher<Int, InvalidError> {
        if age < 0 {
            return Fail(error: InvalidError.zero)
                .eraseToAnyPublisher()
        } else if age > 100 {
            return Fail(error: InvalidError.moreHundred)
                .eraseToAnyPublisher()
        }
        
        return Just(age)
            .setFailureType(to: InvalidError.self)
            .eraseToAnyPublisher()
    }
    
    
}

struct FailPublisherView_Previews: PreviewProvider {
    static var previews: some View {
        FailPublisherView()
    }
}

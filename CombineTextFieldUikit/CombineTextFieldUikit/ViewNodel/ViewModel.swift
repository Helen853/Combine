//
//  ViewModel.swift
//  CombineTextFieldUikit

import Foundation

final class AuthorizationViewModel: ObservableObject {
    @Published var name = ""
    @Published var surName = ""
    
    @Published var validationName: String? = ""
    @Published var validationSurName: String? = ""
    
    init() {
        $name.map { $0.count < 3 ? "Имя должно содержать не менее 3-х символов" : "☑️"}
            .assign(to: &$validationName)
        
        $surName.map { $0.count < 3 ? "Фамилия должна содержать не менее 3-х символов" : "☑️"}
            .assign(to: &$validationSurName)
    }
}

//
//  ViewController.swift
//  CombineTextFieldUikit


import UIKit
import Combine

final class ViewController: UIViewController {
    
    private let nameLabel = UILabel()
    private let surNameLabel = UILabel()
    private let nameTextField = UITextField()
    private let surNameTextField = UITextField()
    
    var viewModel = AuthorizationViewModel()
    var nameanyCancellable: AnyCancellable?
    var surnameanyCancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNameLabel()
        setupSurNameLabel()
        setupnameTextField()
        setupSurNameTextField()
        view.backgroundColor = .lightGray
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.frame = CGRect(x: 50, y: 120, width: 300, height: 50)
        nameLabel.textColor = .red
        nameLabel.font = .systemFont(ofSize: 12)
        nameanyCancellable = viewModel.$validationName
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: nameLabel)
    }
    
    private func setupSurNameLabel() {
        view.addSubview(surNameLabel)
        surNameLabel.frame = CGRect(x: 50, y: 240, width: 320, height: 50)
        surNameLabel.textColor = .red
        surNameLabel.font = .systemFont(ofSize: 12)
        surnameanyCancellable = viewModel.$validationSurName
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: surNameLabel)
    }
    
    private func setupnameTextField() {
        view.addSubview(nameTextField)
        nameTextField.frame = CGRect(x: 50, y: 80, width: 280, height: 50)
        nameTextField.placeholder = "Name"
        //nameTextField.delegate = self
        nameTextField.borderStyle = .roundedRect
    }
    
    private func setupSurNameTextField() {
        view.addSubview(surNameTextField)
        surNameTextField.frame = CGRect(x: 50, y: 190, width: 280, height: 50)
        surNameTextField.placeholder = "SurName"
        surNameTextField.delegate = self
        surNameTextField.borderStyle = .roundedRect
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        viewModel.name = nameTextField.text ?? " "
        viewModel.surName = surNameTextField.text ?? " "
        return true
    }
}


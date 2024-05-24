//
//  ViewController.swift
//  FutureUIkit
//
//  Created by Киса Мурлыса on 23.05.2024.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let textField = UITextField()
    private let checkButton = UIButton()
    private let label = UILabel()
    
    var viewModel = NumberViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureButton()
        configureLabel()
    }
    
    private func configureTextField() {
        view.addSubview(textField)
        textField.frame = CGRect(x: 50, y: 0, width: 280, height: 50)
        textField.center.y = view.center.y
        textField.placeholder = "Введите число"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(inputText), for: .editingChanged)
    }
    
    private func configureButton() {
        view.addSubview(checkButton)
        checkButton.frame = CGRect(x: 70, y: 450, width: 250, height: 50)
        checkButton.setTitle("Проверить простоту числа", for: .normal)
        checkButton.setTitleColor(.blue, for: .normal)
        checkButton.addTarget(self, action: #selector(tappedCheck), for: .touchUpInside)
        
    }
    
    private func configureLabel() {
        view.addSubview(label)
        label.frame = CGRect(x: 120, y: 500, width: 300, height: 50)
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        viewModel.$textAfterCheck.subscribe(Subscribers.Assign(object: label, keyPath: \.text))
    }
    
    @objc private func tappedCheck() {
        viewModel.fetch()
    }
    
    @objc private func inputText() {
        viewModel.inputText = textField.text ?? ""
    }


}


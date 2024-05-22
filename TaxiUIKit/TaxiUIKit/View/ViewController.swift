//
//  ViewController.swift
//  TaxiUIKit

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let statusLabel = UILabel()
    private let dataLabel = UILabel()
    private let cancelButton = UIButton()
    private let searchButton = UIButton()
    
    var viewModel = TaxiViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "taxi")
        setupStatusLabel()
        setupDataLabel()
        setupCancelLabel()
        setupSearchLabel()
        
    }
    
    private func setupStatusLabel() {
        let subscr2 = Subscribers.Assign(object: statusLabel, keyPath: \.text)
        viewModel.$status.subscribe(subscr2)
        view.addSubview(statusLabel)
        statusLabel.frame = CGRect(x: 120, y: 300, width: 200, height: 50)
        statusLabel.font = .systemFont(ofSize: 18)
        statusLabel.textColor = .black
       
        
    }
    
    private func setupDataLabel() {
        let subscr1 = Subscribers.Assign(object: dataLabel, keyPath: \.text)
        viewModel.$data.subscribe(subscr1)
        view.addSubview(dataLabel)
        dataLabel.frame = CGRect(x: 50, y: 250, width: 350, height: 50)
        dataLabel.font = .systemFont(ofSize: 22)
        dataLabel.textColor = .white

    }
    
    private func setupCancelLabel() {
        view.addSubview(cancelButton)
        cancelButton.frame = CGRect(x: 120, y: 450, width: 150, height: 50)
        cancelButton.backgroundColor = .red
        cancelButton.layer.cornerRadius = 12
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(tappedCancel), for: .touchUpInside)
    }
    
    private func setupSearchLabel() {
        view.addSubview(searchButton)
        searchButton.frame = CGRect(x: 120, y: 520, width: 150, height: 50)
        searchButton.backgroundColor = .white
        searchButton.layer.cornerRadius = 12
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.addTarget(self, action: #selector(tappedSearch), for: .touchUpInside)
    }
    
    @objc private func tappedCancel() {
        viewModel.cancel()
    }
    
    @objc private func tappedSearch() {
        viewModel.refresh()
    }
    
}


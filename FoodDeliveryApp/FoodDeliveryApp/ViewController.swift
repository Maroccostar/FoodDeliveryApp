//
//  ViewController.swift
//  FoodDeliveryApp
//
//  Created by Vasiliy Homenko on 17.04.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "Hello World"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ])
        
        label.font = .Roboto.bold.size(of: 40)
        label.textColor = .white
        
        view.backgroundColor = .brown
        
    }


}


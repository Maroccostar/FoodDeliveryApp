//
//  FDCollectionTitle.swift
//  FoodDeliveryApp
//
//  Created by Vasiliy Homenko on 14.06.2024.
//

import UIKit

class FDCollectionTitle: UIView {
    
    let title = UILabel()
    let viewAll = UIButton()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FDCollectionTitle {
    func setupLayout() {
        configureView()
        configureTitle()
        configureViewAll()
    }

    func configureView() {
        self.backgroundColor = .clear
    }
    
    func configureTitle() {
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .Roboto.bold.size(of: 18)
        title.text = "Title"
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            title.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    func configureViewAll() {
        addSubview(viewAll)
        viewAll.translatesAutoresizingMaskIntoConstraints = false
        viewAll.titleLabel?.font = .Roboto.regular.size(of: 12)
        viewAll.setTitle("View All", for: .normal)
        viewAll.setTitleColor(.black, for: .normal)
        NSLayoutConstraint.activate([
            viewAll.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewAll.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            viewAll.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
}

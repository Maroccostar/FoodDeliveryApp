//
//  ProfileCoordinator.swift
//  FoodDeliveryApp
//
//  Created by Vasiliy Homenko on 18.04.2024.
//

class ProfileCoordinator: Coordinator {
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .black
        navigationController?.pushViewController(vc, animated: true)
    }
    override func finish() {
        print("AppCoordinator finish")
    }
}

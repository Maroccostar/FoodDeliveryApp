//
//  AppCoordinator.swift
//  FoodDeliveryApp
//
//  Created by Vasiliy Homenko on 18.04.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    override func start() {
        showOnboardingFlow()
        // showMainFlow()
    }
    override func finish() {
        print("AppCoordinator finish")
    }
}

// MARK: - Navigation methods
private extension AppCoordinator {
    
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        let onboardingCoordinator = OnboardingCoordinator(type: .onboarding,  navigationController: navigationController, finishDelegate: self)
        addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    func showMainFlow() {
        guard let navigationController = navigationController else { return }
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(type: .home, navigationController: homeNavigationController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage.init(systemName: "circle.hexagonpath"), tag: 0)
        homeCoordinator.finishDelegate = self
        homeCoordinator.start()
        
        let orderNavigationController = UINavigationController()
        let orderCoordinator = OrderCoordinator(type: .order, navigationController: orderNavigationController)
        orderNavigationController.tabBarItem = UITabBarItem(title: "Order", image: UIImage.init(systemName: "circle.hexagonpath"), tag: 1)
        orderCoordinator.finishDelegate = self
        orderCoordinator.start()
        
        let listNavigationController = UINavigationController()
        let listCoordinator = ListCoordinator(type: .list, navigationController: listNavigationController)
        listNavigationController.tabBarItem = UITabBarItem(title: "List", image: UIImage.init(systemName: "circle.hexagonpath"), tag: 2)
        listCoordinator.finishDelegate = self
        listCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .profile, navigationController: profileNavigationController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage.init(systemName: "circle.hexagonpath"), tag: 3)
        profileCoordinator.finishDelegate = self
        profileCoordinator.start()
        
        addChildCoordinator(homeCoordinator)
        addChildCoordinator(orderCoordinator)
        addChildCoordinator(listCoordinator)
        addChildCoordinator(profileCoordinator)
        
        let tabBarControllers = [homeNavigationController, orderNavigationController, listNavigationController, profileNavigationController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
}


extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinators: CoordinatorProtocol) {
        removeRemoveChildCoordinator(childCoordinators)
        
        switch childCoordinators.type {
        case .app:
            return
        default:
            navigationController?.popToRootViewController(animated: false)
        }
    }
}

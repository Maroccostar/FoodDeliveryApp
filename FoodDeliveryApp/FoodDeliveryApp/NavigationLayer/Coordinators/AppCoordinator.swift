//
//  AppCoordinator.swift
//  FoodDeliveryApp
//
//  Created by Vasiliy Homenko on 18.04.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let userStorage = UserStorage.shared
    private let factory = SceneFactory.self
    var tabBarController: UITabBarController?
    
    override func start() {
        if userStorage.passedOnboarding {
            showAuthFlow()
        } else {
//            showOnboardingFlow()
        }
        showMainFlow()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}

// MARK: - Navigation methods
private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        let onboardingCoordinator = factory.makeOnboardingFlow(coordinator: self, finishDelegate: self, navigationController: navigationController)
        onboardingCoordinator.start()
    }
    func showMainFlow() {
        // guard let navigationController = navigationController else { return }
        guard navigationController != nil else { return }
        let tabBarController = factory.makeMainFlow(coordinator: self, finisghDelegate: self)
        self.tabBarController = tabBarController
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        self.window?.layer.add(transition, forKey: kCATransition)
        self.window?.rootViewController = self.tabBarController
    }
    func showAuthFlow() {
        guard let navigationController = navigationController else { return }
        let loginCoordinator = factory.makeLoginFlow(coordinator: self, finishDelegate: self, navigationController: navigationController)
        loginCoordinator.start()
    }
}

// MARK: - FinishDelegate
extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinators: CoordinatorProtocol) {
        removeRemoveChildCoordinator(childCoordinators)
        
        switch childCoordinators.type {
        case .onboarding:
            showAuthFlow()
            navigationController?.viewControllers = [navigationController?.viewControllers.last ?? UIViewController()] 
        case .login:
            showMainFlow()
            navigationController?.viewControllers = [navigationController?.viewControllers.last ?? UIViewController()]
        case .app:
            return
        default:
            navigationController?.popToRootViewController(animated: false)
        }
    }
}

//
//  SceneFactory.swift
//  FoodDeliveryApp
//
//  Created by Vasiliy Homenko on 22.04.2024.
//

import UIKit


struct SceneFactory {
    
    // MARK: - Onboarding flow
    static func makeOnboardingFlow(coordinator: AppCoordinator, finishDelegate: CoordinatorFinishDelegate, navigationController: UINavigationController) -> OnboardingCoordinator{
        let onboardingCoordinator = OnboardingCoordinator(type: .onboarding,  navigationController: navigationController, finishDelegate: finishDelegate)
        coordinator.addChildCoordinator(onboardingCoordinator)
        return onboardingCoordinator
    }
    static func makeLoginFlow(coordinator: AppCoordinator, finishDelegate: CoordinatorFinishDelegate, navigationController: UINavigationController) -> LoginCoordinator {
        let loginCoordinator = LoginCoordinator(type: .login,  navigationController: navigationController, finishDelegate: finishDelegate)
        coordinator.addChildCoordinator(loginCoordinator)
        return loginCoordinator
    }
    
    // MARK: - Onboarding scene
    static func makeOnboardingScene(coordinator: OnboardingCoordinator) -> OnboardingViewController {
        var pages = [OnboardingPartViewController]()
        
        let firstVC = OnboardingPartViewController()
        firstVC.imageToShow = UIImage(resource: .chickenLeg)
        firstVC.titleText = "Delicious Food"
        firstVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        firstVC.buttonText = "Next"
        
        let secondVC = OnboardingPartViewController()
        secondVC.imageToShow = UIImage(resource: .shipped)
        secondVC.titleText = "Fast Shipping"
        secondVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
        secondVC.buttonText = "Next"
        
        let thirdVC = OnboardingPartViewController()
        thirdVC.imageToShow = UIImage(resource: .medal)
        thirdVC.titleText = "Certificate Food"
        thirdVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        thirdVC.buttonText = "Next"
        
        let fourthVC = OnboardingPartViewController()
        fourthVC.imageToShow = UIImage(resource: .creditCard)
        fourthVC.titleText = "Payment Online"
        fourthVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        fourthVC.buttonText = "Cool!"
        
        pages.append(firstVC)
        pages.append(secondVC)
        pages.append(thirdVC)
        pages.append(fourthVC)
        
        let presenter = OnboardingViewPresenter(coordinator: coordinator)
        let viewController = OnboardingViewController(pages: pages, viewOutput: presenter)
        
        return viewController
    }
    
    
    // MARK: - Main flow
    static func makeMainFlow(coordinator: AppCoordinator, finisghDelegate: CoordinatorFinishDelegate) -> TabBarController {
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(type: .home, navigationController: homeNavigationController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(resource: .homeT), tag: 0)
        homeCoordinator.finishDelegate = finisghDelegate
        homeCoordinator.start()
        
        let orderNavigationController = UINavigationController()
        let orderCoordinator = OrderCoordinator(type: .order, navigationController: orderNavigationController)
        orderNavigationController.tabBarItem = UITabBarItem(title: "Order", image: UIImage(resource: .orderT), tag: 1)
        orderCoordinator.finishDelegate = finisghDelegate
        orderCoordinator.start()
        
        let listNavigationController = UINavigationController()
        let listCoordinator = ListCoordinator(type: .list, navigationController: listNavigationController)
        listNavigationController.tabBarItem = UITabBarItem(title: "List", image: UIImage(resource: .listT), tag: 2)
        listCoordinator.finishDelegate = finisghDelegate
        listCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .profile, navigationController: profileNavigationController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(resource: .profileT), tag: 3)
        profileCoordinator.finishDelegate = finisghDelegate
        profileCoordinator.start()
        
        coordinator.addChildCoordinator(homeCoordinator)
        coordinator.addChildCoordinator(orderCoordinator)
        coordinator.addChildCoordinator(listCoordinator)
        coordinator.addChildCoordinator(profileCoordinator)
        
        let tabBarControllers = [homeNavigationController, orderNavigationController, listNavigationController, profileNavigationController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
        return tabBarController
    }
    
    static func makeAuthScene(coordinator: LoginCoordinator) -> LoginViewController {
        let presenter = LoginPresenter(coordinator: coordinator)
        let controller = LoginViewController(viewOutput: presenter, state: .initial)
        presenter.viewInput = controller
        return controller
    }
    static func makeSignInScene(coordinator: LoginCoordinator) -> LoginViewController {
        let presenter = LoginPresenter(coordinator: coordinator)
        let controller = LoginViewController(viewOutput: presenter, state: .signIn)
        presenter.viewInput = controller
        return controller
    }
    static func makeSignUpScene(coordinator: LoginCoordinator) -> LoginViewController {
        let presenter = LoginPresenter(coordinator: coordinator)
        let controller = LoginViewController(viewOutput: presenter, state: .signUp)
        presenter.viewInput = controller
        return controller
    }
    static func makeHomeScene(coordinator: HomeCoordinator) -> HomeViewController {
        // TODO: Add presenter
        let controller = HomeViewController()
        return controller
    }
}

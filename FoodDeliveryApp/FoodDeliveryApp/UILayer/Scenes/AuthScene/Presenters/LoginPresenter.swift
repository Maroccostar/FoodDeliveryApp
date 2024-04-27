//
//  LoginPresenter.swift
//  FoodDeliveryApp
//
//  Created by Vasiliy Homenko on 24.04.2024.
//

import Foundation

protocol LoginViewOutput: AnyObject {
    func loginStart(login: String, password: String)
    func registrationStart()
    func goToFacebookLogin()
    func goToGoogleLogin()
    func goToSignIn()
    func tgoToSignUp()
    func goToForgotPass()
    func back()
}

class LoginPresenter {
    
    private var coordinator: AppCoordinator?
    weak var viewInput: LoginViewInput?
    
    init(coordinator: AppCoordinator? = nil, viewInput: LoginViewInput? = nil) {
        self.coordinator = coordinator
        self.viewInput = viewInput
    }
}

private extension LoginPresenter {
    func goToMainScreen() {
        coordinator?.showMainScene()
    }
}

extension LoginPresenter: LoginViewOutput {
    func loginStart(login: String, password: String) {
        viewInput?.startLoader()
        if login.lowercased() == "1111" && password == "1111" {
            DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
                DispatchQueue.main.async {
                    self.viewInput?.stopLoader()
                    self.goToMainScreen()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                print("wrong email or password")
                self.viewInput?.stopLoader()
            }
        }
    }
    func registrationStart() {
        
    }
    func goToFacebookLogin() {
        
    }
    func goToGoogleLogin() {
        
    }
    func goToSignIn() {
        coordinator?.showSignInScene()
    }
    func tgoToSignUp() {
        coordinator?.showSignUpScene()
    }
    func goToForgotPass() {
        
    }
    func back() {
        
    }
}

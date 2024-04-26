//
//  LoginViewController.swift
//  FoodDeliveryApp
//
//  Created by Vasiliy Homenko on 23.04.2024.
//

import UIKit

// MARK: - LoginViewState
enum LoginViewState {
    case initial
    case signIn
    case signUp
}

protocol LoginViewInput: AnyObject {
    func onSignInTapped()
    func onSignUpTapped()
    func onFacebookTapped()
    func onGoogleTapped()
    func onForgotTapped()
    func onBackPressed()
}

// MARK: - LoginViewController
class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var state: LoginViewState = .initial
    var viewOutput: LoginViewOutput!
    private var isKeyboardShow = false
    private var bottomCTValue = 0.0
    
    // MARK: - Views
    private lazy var bottomView = FDBottomView()
    private lazy var titleLabel = UILabel()
    private lazy var signInUserName = FDTextField()
    private lazy var signInPassword = FDTextField()
    private lazy var signUpUserName = FDTextField()
    private lazy var signUpPassword = FDTextField()
    private lazy var signUpReEnterPass = FDTextField()
    private lazy var forgotLabel = UILabel()
    private lazy var logoImage = UIImageView()
    private lazy var signInButton = FDButton()
    private lazy var signUpButton = FDButton()
    private lazy var verticalStack = UIStackView()
    
    // MARK: - Constraints
    private var stackViewBottomCT = NSLayoutConstraint()

    // MARK: - Initializers
    init(viewOutput: LoginViewOutput, state: LoginViewState) {
        self.viewOutput = viewOutput
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupLayout()
        setupObservers()
    }
    
    deinit {
        stopKeyboardListener()
    }
    
    func facebookPress() {
        print("facebook")
    }
    
    func googlePress() {
        print("google")
    }
}

// MARK: - Layout
private extension LoginViewController {
    func setupLayout() {
        switch state {
        case .initial:
            setupBottomView()
            setupLogoImage()
            setupSignInButton()
            setupSignUpButton()
        case .signIn:
            setupBottomView()
            setupStack()
            setupSignInPassword()
            setupSignInUserName()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel()
        case .signUp:
            setupBottomView()
            setupStack()
            setupSignUpUserName()
            setupSignUpPass()
            setupSignUpReEnterPass()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel()
        }
    }
    func setupStack() {
        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        switch state {
        case .initial:
            return
        case .signIn:
            verticalStack.addArrangedSubview(signInUserName)
            verticalStack.addArrangedSubview(signInPassword)
            bottomCTValue = -262
            stackViewBottomCT = verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: bottomCTValue)
            NSLayoutConstraint.activate([
                verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackViewBottomCT
            ])
        case .signUp:
            verticalStack.addArrangedSubview(signUpUserName)
            verticalStack.addArrangedSubview(signUpPassword)
            verticalStack.addArrangedSubview(signUpReEnterPass)
            bottomCTValue = -227
            stackViewBottomCT = verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: bottomCTValue)
            NSLayoutConstraint.activate([
                verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackViewBottomCT
            ])
        }
    }
    func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.button2Action = facebookPress
        bottomView.button1Action = googlePress
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    func setupSignInPassword() {
        signInPassword.translatesAutoresizingMaskIntoConstraints = false
        signInPassword.placeholder = "Password"
        NSLayoutConstraint.activate([
            signInPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            signInPassword.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            signInPassword.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func setupSignInUserName() {
        signInUserName.translatesAutoresizingMaskIntoConstraints = false
        signInUserName.placeholder = "Username"
        NSLayoutConstraint.activate([
            signInUserName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            signInUserName.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            signInUserName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .Roboto.bold.size(of: 24)
        switch state {
        case .signIn:
            titleLabel.text = "Sign In"
        case .signUp:
            titleLabel.text = "Sign Up"
        case .initial:
            return
        }
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: verticalStack.topAnchor, constant: -38),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 34),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    func setupLogoImage() {
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(resource: .loginLogo)
        logoImage.layer.cornerRadius = 24
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 109),
            logoImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 57),
            logoImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -57),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor)
        ])
    }
    func setupSignInButton() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In")
        signInButton.scheme = .orange
        signInButton.action = onSignInTapped
        switch state {
        case .initial:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 60),
                signInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                signInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        case .signIn:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 30),
                signInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                signInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        case .signUp:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 30),
                signInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                signInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up")
        signUpButton.scheme = .gray
        signUpButton.action = onSignUpTapped
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            signUpButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func setupForgotLabel() {
        view.addSubview(forgotLabel)
        forgotLabel.translatesAutoresizingMaskIntoConstraints = false
        forgotLabel.text = "Forgot Password?"
        forgotLabel.font = .Roboto.regular.size(of: 14)
        forgotLabel.textColor = AppColors.bottomViewGray
        NSLayoutConstraint.activate([
            forgotLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            forgotLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)
        ])
    }
    func setupSignUpPass() {
        signUpPassword.translatesAutoresizingMaskIntoConstraints = false
        signUpPassword.placeholder = "Enter password"
        NSLayoutConstraint.activate([
            signUpPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            signUpPassword.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            signUpPassword.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func setupSignUpUserName() {
        signUpUserName.translatesAutoresizingMaskIntoConstraints = false
        signUpUserName.placeholder = "Enter Username"
        NSLayoutConstraint.activate([
            signUpUserName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            signUpUserName.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            signUpUserName.heightAnchor.constraint(equalToConstant: 50)
        ])

    }
    func setupSignUpReEnterPass() {
        signUpReEnterPass.translatesAutoresizingMaskIntoConstraints = false
        signUpReEnterPass.placeholder = "Re-Enter Password"
        NSLayoutConstraint.activate([
            signUpReEnterPass.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            signUpReEnterPass.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            signUpReEnterPass.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - LoginViewInput delegate
extension LoginViewController: LoginViewInput {
    func onSignInTapped() {
        switch state {
        case .initial:
            viewOutput.goToSignIn()
        case .signIn:
            return
        case .signUp:
            return
        }
    }
    func onSignUpTapped() {
        switch state {
        case .initial:
            viewOutput.tgoToSignUp()
        case .signIn:
            return
        case .signUp:
            return
        }
    }
    func onFacebookTapped() {
        
    }
    func onGoogleTapped() {
        
    }
    func onForgotTapped() {
        
    }
    func onBackPressed() {
    
    }
}


// MARK: - Observers
private extension LoginViewController {
    func setupObservers() {
        startKeyboardListener()
    }
    func startKeyboardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    func stopKeyboardListener() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        if !isKeyboardShow {
            UIView.animate(withDuration: 0.3) {
                self.stackViewBottomCT.constant -= keyboardHeight/4
                self.view.layoutIfNeeded()
                self.isKeyboardShow = true
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        if isKeyboardShow {
            UIView.animate(withDuration: 0.3) {
                self.stackViewBottomCT.constant = self.bottomCTValue
                self.view.layoutIfNeeded()
                self.isKeyboardShow = false
            }
        }

    }
}

//#Preview("LoginVC") {
//    LoginViewController(viewOutput: LoginPresenter(), state: .initial)
//}

//
//  WelcomeViewController.swift
//  UpTodo
//
//  Created by Timur Gazizulin on 5.12.23.
//

import SnapKit
import UIKit

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
    }

    // MARK: - Private constants

    private enum UIConstants {
        static let labelFontSize: CGFloat = 32
        static let subtitleLabelFontSize: CGFloat = 16
        static let titleLabelWidth: CGFloat = 300
        static let titleLabelHeight: CGFloat = 38
        static let viewToTitleInset: CGFloat = 170
        static let subtitleLabelWidth: CGFloat = 280
        static let subtitleLabelHeight: CGFloat = 48
        static let titleToSubtitleLabelOffset: CGFloat = 20
        static let buttonWidth: CGFloat = 350
        static let buttonHeight: CGFloat = 50
        static let viewToRegistrationButtonBottomInset: CGFloat = 50
        static let regToLoginButtonOffset: CGFloat = -20
    }

    // MARK: - Private properties

    private let titleLabel: UILabel = {
        let label = UILabel()

        label.text = "Welcome to UpTodo"
        label.textColor = .white
        label.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1

        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()

        label.text = "Please login to your account or create new account to continue"
        label.textColor = .white
        label.alpha = 0.67
        label.font = .systemFont(ofSize: UIConstants.subtitleLabelFontSize, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 2

        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()

        button.configuration = .filled()
        button.setTitle("LOGIN", for: .normal)

        button.setTitleColor(.white, for: .normal)
        button.tintColor = UIColor(cgColor: CGColor(red: 136 / 255, green: 117 / 255, blue: 255 / 17, alpha: 1))
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var registrationButton: UIButton = {
        let button = UIButton()

        button.configuration = .bordered()
        button.setTitle("CREATE ACCOUNT", for: .normal)

        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)

        button.addTarget(self, action: #selector(registrationButtonPressed), for: .touchUpInside)
        return button
    }()
}

private extension WelcomeViewController {
    func initialization() {
        view.backgroundColor = UIColor(cgColor: CGColor(red: 15 / 255, green: 15 / 255, blue: 16 / 255, alpha: 1))

        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItems = getLeftBarButtonItems()

        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(UIConstants.viewToTitleInset)
            make.width.equalTo(UIConstants.titleLabelWidth)
            make.height.equalTo(UIConstants.titleLabelHeight)
        }

        view.addSubview(subtitleLabel)

        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(UIConstants.titleToSubtitleLabelOffset)
            make.width.equalTo(UIConstants.subtitleLabelWidth)
            make.height.equalTo(UIConstants.subtitleLabelHeight)
        }

        view.addSubview(registrationButton)

        registrationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(UIConstants.viewToRegistrationButtonBottomInset)
            make.width.equalTo(UIConstants.buttonWidth)
            make.height.equalTo(UIConstants.buttonHeight)
        }

        view.addSubview(loginButton)

        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(registrationButton.snp.top).offset(UIConstants.regToLoginButtonOffset)
            make.width.equalTo(UIConstants.buttonWidth)
            make.height.equalTo(UIConstants.buttonHeight)
        }
    }

    func getLeftBarButtonItems() -> [UIBarButtonItem] {
        var items = [UIBarButtonItem]()

        let chevronItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))

        items.append(chevronItem)
        return items
    }

    @objc func backButtonPressed() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }

    @objc func loginButtonPressed() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }

    @objc func registrationButtonPressed() {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
}

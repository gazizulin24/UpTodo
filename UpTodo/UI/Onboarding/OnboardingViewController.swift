//
//  OnboardingViewController.swift
//  UpTodo
//
//  Created by Timur Gazizulin on 5.12.23.
//

import SnapKit
import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - Public methods

    func configure(with item: OnboardingPageInfo) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        imageView.image = UIImage(named: item.imageName)

        if item.isLast {
            forwardButton.setTitle(" GET STARTED ", for: .normal)
            forwardButton.removeTarget(self, action: nil, for: .touchUpInside)
            forwardButton.addTarget(self, action: #selector(endOnboarding), for: .touchUpInside)
        }
    }

    @objc func endOnboarding() {
        print("end")
        navigationController?.pushViewController(WelcomeViewController(), animated: true)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
    }

    // MARK: - Private constants

    private enum UIConstants {
        static let imageSize: CGFloat = 350
        static let viewTopToImageInset: CGFloat = 100
        static let labelFontSize: CGFloat = 32
        static let imageToTitleLabelOffset: CGFloat = 50
        static let titleLabelHeight: CGFloat = 38
        static let titleLabelWidth: CGFloat = 350
        static let subtitleLabelFontSize: CGFloat = 16
        static let titleToSubtitleLabelOffset: CGFloat = 30
        static let subtitleLabelHeight: CGFloat = 48
        static let subtitleLabelWidth: CGFloat = 300
    }

    // MARK: - Private properties

    private lazy var backButton: UIButton = {
        let button = UIButton()

        button.setTitle("BACK", for: .normal)

        button.setTitleColor(UIColor(cgColor: CGColor(red: 1, green: 1, blue: 1, alpha: 0.44)), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var forwardButton: UIButton = {
        let button = UIButton()

        button.configuration = .filled()
        button.setTitle(" NEXT ", for: .normal)

        button.setTitleColor(.white, for: .normal)
        button.tintColor = UIColor(cgColor: CGColor(red: 136 / 255, green: 117 / 255, blue: 255 / 17, alpha: 1))
        button.addTarget(self, action: #selector(forwardButtonPressed), for: .touchUpInside)
        return button
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "OnboardingImage1")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()

        label.text = "Manage your tasks"
        label.textColor = .white
        label.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1

        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()

        label.text = "You can easily manage all of your daily tasks in UpTodo for free"
        label.textColor = .white
        label.font = .systemFont(ofSize: UIConstants.subtitleLabelFontSize, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 2

        return label
    }()
}

// MARK: - Private methods

private extension OnboardingViewController {
    @objc func forwardButtonPressed() {
        if let viewController = parent as? OnboardingPageViewController {
            viewController.nextPage()
        }
    }

    @objc func backButtonPressed() {
        if let viewController = parent as? OnboardingPageViewController {
            viewController.prevPage()
        }
    }

    func initialization() {
        view.backgroundColor = UIColor(cgColor: CGColor(red: 15 / 255, green: 15 / 255, blue: 16 / 255, alpha: 1))

        view.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(UIConstants.viewTopToImageInset)
            make.size.equalTo(UIConstants.imageSize)
        }

        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(UIConstants.imageToTitleLabelOffset)
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

        view.addSubview(backButton)

        backButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottomMargin)
            make.leading.equalTo(view.snp.leadingMargin)
        }

        view.addSubview(forwardButton)

        forwardButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottomMargin)
            make.trailing.equalTo(view.snp.trailingMargin)
        }
    }
}

//
//  CustomTabBar.swift
//  UpTodo
//
//  Created by Timur Gazizulin on 5.12.23.
//

import SnapKit
import UIKit

class CustomTabBar: UITabBar {
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private constants

    private enum UIConstants {
        static let plusButtonSizeMultiplier = 0.7
    }

    // MARK: - Private properties

    private lazy var plusButton: UIButton = {
        let button = PlusButton()
        button.layer.cornerRadius = self.bounds.height * UIConstants.plusButtonSizeMultiplier

        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - HitTest

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        plusButton.frame.contains(point) ? plusButton : super.hitTest(point, with: event)
    }

    @objc func buttonTapped() {
        NotificationCenter.default.post(name: Notification.Name("addTaskButtonPressed"), object: nil)
    }
}

// MARK: - Private methods

private extension CustomTabBar {
    func configure() {
        isTranslucent = false
        tintColor = .white
        backgroundColor = UIColor(cgColor: CGColor(red: 54 / 255, green: 54 / 255, blue: 54 / 255, alpha: 1))
        barTintColor = UIColor(cgColor: CGColor(red: 54 / 255, green: 54 / 255, blue: 54 / 255, alpha: 1))

        addSubview(plusButton)

        plusButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.snp.top)
            make.size.equalTo(self.snp.height).multipliedBy(UIConstants.plusButtonSizeMultiplier)
        }
    }
}

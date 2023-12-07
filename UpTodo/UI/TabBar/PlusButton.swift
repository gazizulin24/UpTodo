//
//  PlusButton.swift
//  UpTodo
//
//  Created by Timur Gazizulin on 5.12.23.
//

import UIKit

final class PlusButton: UIButton {
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout Subviews

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = frame.width / 2
    }
}

// MARK: - Private methods

private extension PlusButton {
    func configure() {
        setImage(UIImage(systemName: "plus"), for: .normal)
        tintColor = .white
        backgroundColor = UIColor(cgColor: CGColor(red: 134 / 255, green: 135 / 255, blue: 231 / 255, alpha: 1))
    }
}

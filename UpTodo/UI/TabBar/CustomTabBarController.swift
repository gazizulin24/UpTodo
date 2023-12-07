//
//  CustomTabBarController.swift
//  UpTodo
//
//  Created by Timur Gazizulin on 5.12.23.
//

import UIKit

class CustomTabBarController: UITabBarController {
    // MARK: - Private properties

    private let customTabBar = CustomTabBar()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }

    @objc func addTaskButtonPressed() {
        let addTaskViewController = UIViewController()

        addTaskViewController.view.backgroundColor = UIColor(cgColor: CGColor(red: 54 / 255, green: 54 / 255, blue: 54 / 255, alpha: 1))
        present(addTaskViewController, animated: true)
    }
}

// MARK: - Private methods

private extension CustomTabBarController {
    func initialize() {
        setValue(customTabBar, forKey: "tabBar")

        setupNotifications()

        viewControllers = getViewControllers()
    }

    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(addTaskButtonPressed), name: Notification.Name("addTaskButtonPressed"), object: nil)
    }

    func getViewControllers() -> [UIViewController] {
        let indexViewController = UIViewController()

        indexViewController.view.backgroundColor = .blue
        indexViewController.tabBarItem.title = "Index"
        indexViewController.tabBarItem.image = UIImage(systemName: "house")
        indexViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")

        let calendarViewController = UIViewController()

        calendarViewController.view.backgroundColor = .red
        calendarViewController.tabBarItem.title = "Calendar"
        calendarViewController.tabBarItem.image = UIImage(systemName: "calendar.circle")
        calendarViewController.tabBarItem.selectedImage = UIImage(systemName: "calendar.circle.fill")

        let focuseViewController = UIViewController()

        focuseViewController.view.backgroundColor = .brown
        focuseViewController.tabBarItem.title = "Focuse"
        focuseViewController.tabBarItem.image = UIImage(systemName: "clock")
        focuseViewController.tabBarItem.selectedImage = UIImage(systemName: "clock.fill")

        let profileViewController = UIViewController()

        profileViewController.view.backgroundColor = .cyan
        profileViewController.tabBarItem.title = "Profile"
        profileViewController.tabBarItem.image = UIImage(systemName: "person")
        profileViewController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")

        let spacerViewController = UIViewController()
        spacerViewController.tabBarItem.isEnabled = false

        return [indexViewController, calendarViewController, spacerViewController, focuseViewController, profileViewController]
    }
}

//
//  OnboardingPageViewController.swift
//  UpTodo
//
//  Created by Timur Gazizulin on 5.12.23.
//

import SnapKit
import UIKit

class OnboardingPageViewController: UIPageViewController {
    // MARK: - Initialization

    override init(transitionStyle _: UIPageViewController.TransitionStyle, navigationOrientation _: UIPageViewController.NavigationOrientation, options _: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)

        setViewControllers([onboardingPages.first!], direction: .forward, animated: true)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }

    // MARK: - Public methods

    func nextPage() {
        print("next")

        guard let currentViewController = viewControllers?.first else { return }

        if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
            setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
        }
    }

    func prevPage() {
        print("prev")

        guard let currentViewController = viewControllers?.first else { return }

        if let previousPage = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) {
            setViewControllers([previousPage], direction: .reverse, animated: true, completion: nil)
        }
    }

    // MARK: - Private properties

    private let onboardingPages: [OnboardingViewController] = {
        var pages = [OnboardingViewController]()

        let firstPage = OnboardingViewController()
        firstPage.configure(with: OnboardingPageInfo(imageName: "OnboardingImage1", title: "Manage Your tasks", subtitle: "You can easily manage all of your daily tasks in UpTodo for free", isLast: false))
        pages.append(firstPage)

        let secondPage = OnboardingViewController()
        secondPage.configure(with: OnboardingPageInfo(imageName: "OnboardingImage2", title: "Create daily routine", subtitle: "In Uptodo  you can create your personalized routine to stay productive", isLast: false))
        pages.append(secondPage)

        let thirdPage = OnboardingViewController()
        thirdPage.configure(with: OnboardingPageInfo(imageName: "OnboardingImage3", title: "Orgonaize your tasks", subtitle: "You can organize your daily tasks by adding your tasks into separate categories", isLast: true))
        pages.append(thirdPage)

        return pages
    }()

    private lazy var skipButton: UIButton = {
        let button = UIButton()

        button.setTitle("SKIP", for: .normal)
        button.setTitleColor(UIColor(cgColor: CGColor(red: 1, green: 1, blue: 1, alpha: 0.44)), for: .normal)
        button.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        return button
    }()
}

// MARK: - Private methods

private extension OnboardingPageViewController {
    func initialization() {
        dataSource = self

        view.backgroundColor = UIColor(cgColor: CGColor(red: 15 / 255, green: 15 / 255, blue: 16 / 255, alpha: 1))

        configurePageControl()

        view.addSubview(skipButton)

        skipButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.equalTo(view.snp.leadingMargin)
        }
    }

    func configurePageControl() {
        let pageControl = UIPageControl.appearance()

//        pageControl.pageIndicatorTintColor = view.backgroundColor
//        pageControl.pageIndicatorTintColor = UIColor(cgColor: CGColor(red: 100/225, green: 100/225, blue: 100/225, alpha: 1))
//        pageControl.currentPageIndicatorTintColor = .white

        // hidden
        pageControl.isHidden = true
    }

    @objc func skipButtonPressed() {
        print("skip")
        navigationController?.pushViewController(WelcomeViewController(), animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingViewController else { return nil }

        if let index = onboardingPages.firstIndex(of: viewController) {
            if index > 0 {
                return onboardingPages[index - 1]
            }
        }

        return nil
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingViewController else { return nil }

        if let index = onboardingPages.firstIndex(of: viewController) {
            if index < onboardingPages.count - 1 {
                return onboardingPages[index + 1]
            }
        }

        return nil
    }

    func presentationIndex(for _: UIPageViewController) -> Int {
        return 0
    }

    func presentationCount(for _: UIPageViewController) -> Int {
        return onboardingPages.count
    }
}

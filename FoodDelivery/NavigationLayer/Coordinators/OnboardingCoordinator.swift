import UIKit

class OnboardingCoordinator: Coordinator {
    
    override func start() {
        showOnboarding()
    }
    
    override func finish() {
        print("AppCoordinatorFinish")
    }
}

private extension OnboardingCoordinator {
    func showOnboarding() {
        var pages = [UIViewController]()
        let firstVC = UIViewController()
        firstVC.view.backgroundColor = .red
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .green
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .yellow
        
        pages.append(firstVC)
        pages.append(secondVC)
        pages.append(thirdVC)
        
        let presenter = OnboardingViewPresenter(coordinator: self)
        let viewController = OnboardingViewController(
            pages: pages,
            viewOutput: presenter
        )
        navigationController?.pushViewController(viewController, animated: true)
    }
}

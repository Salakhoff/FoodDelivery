import UIKit

class AppCoordinator: Coordinator {
    override func start() {
//        showOnboardingFlow()
        showMainFlow()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
    
}

// MARK: - Navigation Methods

private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        let onboardingCoordinator = OnboardingCoordinator(
            type: .onboarding,
            navigationController: navigationController,
            finishDelegate: self
        )
        addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    func showMainFlow() {
        guard let navigationController = navigationController else { return }
        
        let homeNavigationControoler = UINavigationController()
        let homeCoordinator = HomeCoordinator(
            type: .home,
            navigationController: homeNavigationControoler
        )
        homeNavigationControoler.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        homeCoordinator.finishDelegate = self
        homeCoordinator.start()
        
        let orderNavigationControoler = UINavigationController()
        let orderCoordinator = OrderCoordinator(
            type: .order,
            navigationController: orderNavigationControoler
        )
        orderNavigationControoler.tabBarItem = UITabBarItem(title: "Order", image: nil, tag: 1)
        orderCoordinator.finishDelegate = self
        orderCoordinator.start()
        
        let listNavigationControoler = UINavigationController()
        let listCoordinator = ListCoordinator(
            type: .list,
            navigationController: listNavigationControoler
        )
        listNavigationControoler.tabBarItem = UITabBarItem(title: "My List", image: nil, tag: 0)
        listCoordinator.finishDelegate = self
        listCoordinator.start()
        
        let profileNavigationControoler = UINavigationController()
        let profileCoordinator = ProfileCoordinator(
            type: .profile,
            navigationController: profileNavigationControoler
        )
        profileNavigationControoler.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 0)
        profileCoordinator.finishDelegate = self
        profileCoordinator.start()
        
        addChildCoordinator(homeCoordinator)
        addChildCoordinator(orderCoordinator)
        addChildCoordinator(listCoordinator)
        addChildCoordinator(profileCoordinator)
        
        let tabBarControllers = [
            homeNavigationControoler,
            orderNavigationControoler,
            listNavigationControoler,
            profileNavigationControoler
        ]
        
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
}

// MARK: - CoordinatorFinishDelegate

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)
        
        switch childCoordinator.type {
        case .app:
            return
        default:
            navigationController?.popViewController(animated: false)
        }
    }
}

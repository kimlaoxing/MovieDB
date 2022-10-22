import Foundation
import UIKit
import Router

extension FavoriteTabBarRoute where Self: Router {
    public func makeFavoriteTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = FavoriteListViewController()
        let vm = DefaultFavoriteListViewModel(router: router as! HomeTabRoute)
        vc.viewModel = vm
        vc.navigationItem.backButtonTitle = ""
        router.root = vc
        
        let navigation = UINavigationController(rootViewController: vc)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigation.navigationBar.standardAppearance = navBarAppearance
        navigation.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigation.navigationBar.tintColor = .white
        navigation.tabBarItem.title = "Favorite"
        navigation.tabBarItem.image = UIImage(systemName: "star.fill")
        navigation.navigationBar.prefersLargeTitles = false
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.backgroundColor = .gray
        return navigation
    }
}

extension DefaultRouter: FavoriteTabBarRoute {}

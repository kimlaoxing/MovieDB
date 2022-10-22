import Foundation
import UIKit
import Router

extension ProfileTabRoute where Self: Router {
    public func makeProfileTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = ProfileViewController()
        let vm = DefaultProfileViewViewModel(router: router)
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
        navigation.tabBarItem.title = "Profile"
        navigation.tabBarItem.image = UIImage(systemName: "person")
        navigation.navigationBar.prefersLargeTitles = false
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.backgroundColor = .gray
        return navigation
    }
    func toEditName(with transition: Transition, delegate: ProfileEditDelegate) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = ProfileEditViewController()
        vc.state = .name
        vc.delegate = delegate
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    func toEditEmail(with transition: Transition, delegate: ProfileEditDelegate) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = ProfileEditViewController()
        vc.state = .email
        vc.state = .email
        vc.delegate = delegate
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    public func toEditName(_ delegate: ProfileEditDelegate) {
        toEditName(with: PushTransition(), delegate: delegate)
    }
    
    public func toEditEmail(_ delegate: ProfileEditDelegate) {
        toEditEmail(with: PushTransition(), delegate: delegate)
    }
}

extension DefaultRouter: ProfileTabRoute {}

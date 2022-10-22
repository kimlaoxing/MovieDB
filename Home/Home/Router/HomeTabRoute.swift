import Foundation
import UIKit
import Router

extension HomeTabRoute where Self: Router {
    public func makeHomeTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = BaseViewController()
        let vm = DefaultBaseViewModel(router: router)
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
        navigation.tabBarItem.title = "Home"
        navigation.tabBarItem.image = UIImage(systemName: "house")
        navigation.navigationBar.prefersLargeTitles = false
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.backgroundColor = .gray
        return navigation
    }
    
    func toDetailMove(with transition: Transition, id: Int) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = DetailBaseViewController()
        let vm = DefaultDetailBaseViewModel(id: id)
        vc.viewModel = vm
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    func toNowPlayingSection(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = ListSectionViewController()
        let vm = DefaultBaseViewModel(router: router)
        vc.viewModel = vm
        vc.category = .nowPlaying
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    func toPopularMovieSection(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = ListSectionViewController()
        let vm = DefaultBaseViewModel(router: router)
        vc.viewModel = vm
        vc.category = .popular
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    func toTopRatedSection(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = ListSectionViewController()
        let vm = DefaultBaseViewModel(router: router)
        vc.viewModel = vm
        vc.category = .topRated
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    func toPageUpComingSection(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = ListSectionViewController()
        let vm = DefaultBaseViewModel(router: router)
        vc.viewModel = vm
        vc.category = .upComing
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
}

extension DefaultRouter: HomeTabRoute {
    public func toDetailMovie(id: Int) {
        toDetailMove(with: PushTransition(), id: id)
    }
    
    public func toNowPlayingSection() {
        toNowPlayingSection(with: PushTransition())
    }
    
    public func toPopularMovieSection() {
        toPopularMovieSection(with: PushTransition())
    }
    
    public func toTopRatedSection() {
        toTopRatedSection(with: PushTransition())
    }
    
    public func toPageUpComingSection() {
        toPageUpComingSection(with: PushTransition())
    }

}

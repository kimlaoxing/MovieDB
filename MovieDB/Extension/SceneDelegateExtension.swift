import Foundation
import UIKit
import Router
import Favorite
import Home
import Profile

extension SceneDelegate {
    func willConnectTo(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let mainRouter = DefaultRouter(rootTransition: ModalTransition())
        let tabs = [
            mainRouter.makeHomeTab(),
            mainRouter.makeFavoriteTab(),
            mainRouter.makeProfileTab()
        ]
        let home = TabBar(vc: tabs)
        home.selectedIndex = 0
        self.window?.rootViewController = home
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}

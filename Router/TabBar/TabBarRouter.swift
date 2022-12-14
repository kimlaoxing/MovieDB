import UIKit

public protocol HomeTabRoute {
    func makeHomeTab() -> UIViewController
    func toDetailMovie(id: Int)
    func toNowPlayingSection()
    func toPopularMovieSection()
    func toTopRatedSection()
    func toPageUpComingSection()
    func popUpError(with errorMessage: String)
}

public protocol FavoriteTabBarRoute {
    func makeFavoriteTab() -> UIViewController
}

public protocol ProfileTabRoute {
    func makeProfileTab() -> UIViewController
    func toEditName(_ delegate: ProfileEditDelegate)
    func toEditEmail(_ delegate: ProfileEditDelegate)
}

public protocol ProfileEditDelegate: AnyObject {
    func getEmail()
    func getName()
}

public protocol ComponentsRouter {
    func toErrorView() -> UIViewController
}


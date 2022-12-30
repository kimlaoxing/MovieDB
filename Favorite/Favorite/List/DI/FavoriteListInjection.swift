import Foundation

final class FavoriteListInjection: NSObject {
    private func provideRepository() -> FavoriteListRepositoryProtocol {
        let local: FavoriteLocalDataSource = FavoriteLocalDataSource.sharedInstance
        return FavoriteListRepository.sharedInstance(local)
    }
    
    func provideFavoriteList() -> FavoriteListUseCaseProtocol {
        let repository = provideRepository()
        return FavoriteListInteractor(repository: repository)
    }
}

import Foundation
import Favorite

final class DetailBaseInjection: NSObject {
    
    private func provideRepository() -> DetailBaseRepositoryProtocol {
        let remote: DetailBaseRemoteDataSource = DetailBaseRemoteDataSource.sharedInstance
        return DetailBaseRepository.sharedInstance(remote)
    }
    
    private func provideFavoriteRepository() -> FavoriteListRepositoryProtocol {
        let local: FavoriteLocalDataSource = FavoriteLocalDataSource.sharedInstance
        return FavoriteListRepository.sharedInstance(local)
    }
    
    func provideDetailBase() -> DetailBaseUseCaseProtocol {
        let repository = provideRepository()
        let favoriteRepository = provideFavoriteRepository()
        return DetailBaseInteractor(repository: repository, favoriteRepository: favoriteRepository)
    }
}

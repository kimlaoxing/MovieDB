import Foundation

final class BaseInjection: NSObject {
    
    private func provideRepository() -> BaseRepositoryProtocol {
        let remote: BaseRemoteDataSource = BaseRemoteDataSource.sharedInstance
        return BaseRepository.sharedInstance(remote)
    }
    
    func provideBase() -> BaseUseCaseProtocol {
        let repository = provideRepository()
        return BaseInteractor(repository: repository)
    }    
}

import Foundation

final class BaseDetailInjection: NSObject {
    
    private func provideRepository() -> DetailBaseRepositoryProtocol {
        let remote: DetailBaseRemoteDataSource = DetailBaseRemoteDataSource.sharedInstance
        return DetailBaseRepository.sharedInstance(remote)
    }
    
    func provideDetailBase() -> DetailBaseUseCaseProtocol {
        let repository = provideRepository()
        return DetailBaseInteractor(repository: repository)
    }
}

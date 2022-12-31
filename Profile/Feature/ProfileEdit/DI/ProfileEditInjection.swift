import Foundation

final class ProfileEditInjection: NSObject {
    
    private func provideRepository() -> ProfileEditRepositoryProtocol {
        let local: ProfileEditLocalDataSource = ProfileEditLocalDataSource.sharedInstance
        return ProfileEditRepository.sharedInstance(local)
    }
    
    func provideProfileEdit() -> ProfileEditUseCaseProtocol {
        let repository = provideRepository()
        return ProfileEditInteractor(repository: repository)
    }
}

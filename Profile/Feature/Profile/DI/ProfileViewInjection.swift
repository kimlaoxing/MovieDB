import Foundation

final class ProfileViewInjection: NSObject {
    private func provideRepository () -> ProfileEditRepositoryProtocol {
        let local: ProfileEditLocalDataSource = ProfileEditLocalDataSource.sharedInstance
        return ProfileEditRepository.sharedInstance(local)
    }
    
    func provideProfileView() -> ProfileViewUseCaseProtocol {
        let repository = provideRepository()
        return ProfileViewInteractor(repository: repository)
    }
}

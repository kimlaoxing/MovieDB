import Foundation

protocol ProfileEditUseCaseProtocol {
   func saveEmail(with email: String, forKey: String)
   func saveName(with name: String, forKey: String)
}

final class ProfileEditInteractor: ProfileEditUseCaseProtocol {
    private let repository: ProfileEditRepositoryProtocol
    
    required init(
        repository: ProfileEditRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    func saveEmail(with email: String, forKey: String) {
        self.repository.saveEmail(with: email, forKey: forKey)
    }
    
    func saveName(with name: String, forKey: String) {
        self.repository.saveName(with: name, forKey: forKey)
    }
}

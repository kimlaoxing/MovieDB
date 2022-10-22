import Foundation

protocol ProfileEditDomain {
    mutating func saveEmail(with email: String, forKey: String)
    mutating func saveName(with name: String, forKey: String)
}

final class ProfileEditUseCase: ProfileEditDomain {
    
    private var repository: ProfileEditRepository
    
    init() {
        self.repository = ProfileEditRepositoryData()
    }
    
    func saveEmail(with email: String, forKey: String) {
        self.repository.saveEmail(with: email, forKey: forKey)
    }
    
    func saveName(with name: String, forKey: String) {
        self.repository.saveName(with: name, forKey: forKey)
    }
}

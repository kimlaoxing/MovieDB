import Foundation
import UIKit

protocol ProfileViewUseCaseProtocol {
    func retriveEmail(with forKey: String, completion: @escaping(String) -> Void)
    func retriveName(with forKey: String, completion: @escaping(String) -> Void)
    func saveImage(with image: UIImage)
    func retriveImage(_ completion: @escaping(UIImage) -> Void)
}

final class ProfileViewInteractor: ProfileViewUseCaseProtocol {
    private let repository: ProfileEditRepositoryProtocol
    
    required init(
        repository: ProfileEditRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    func retriveEmail(with forKey: String, completion: @escaping (String) -> Void) {
        self.repository.retriveEmail(with: forKey) { data in
            completion(data)
        }
    }
    
    func retriveName(with forKey: String, completion: @escaping (String) -> Void) {
        self.repository.retriveName(with: forKey) { data in
            completion(data)
        }
    }
    
    func saveImage(with image: UIImage) {
        self.repository.saveImage(with: image)
    }
    
    func retriveImage(_ completion: @escaping (UIImage) -> Void) {
        self.repository.retriveImage { data in
            completion(data)
        }
    }
}

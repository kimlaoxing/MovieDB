import Foundation
import UIKit

protocol ProfileViewDomain {
    mutating func retriveEmail(with forKey: String, completion: @escaping(String) -> Void)
    mutating func retriveName(with forKey: String, completion: @escaping(String) -> Void)
    mutating func saveImage(with image: UIImage)
    mutating func retriveImage(_ completion: @escaping(UIImage) -> Void)
}

final class ProfileViewUseCase: ProfileViewDomain {
    
    private var repository: ProfileEditRepository
    
    init() {
        self.repository = ProfileEditRepositoryData()
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

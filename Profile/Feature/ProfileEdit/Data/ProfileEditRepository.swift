import Foundation
import UIKit

protocol ProfileEditRepositoryProtocol {
    func saveEmail(with email: String, forKey: String)
    func saveName(with name: String, forKey: String)
    func retriveEmail(with forKey: String, completion: @escaping(String) -> Void)
    func retriveName(with forKey: String, completion: @escaping(String) -> Void)
    func saveImage(with image: UIImage)
    func retriveImage(_ completion: @escaping(UIImage) -> Void)
}

final class ProfileEditRepository: NSObject {
    typealias ProfileEditInstance = (ProfileEditLocalDataSource) -> ProfileEditRepository
    
    fileprivate let localData: ProfileEditLocalDataSource
    
    init(localData: ProfileEditLocalDataSource) {
        self.localData = localData
    }
    
    static let sharedInstance: ProfileEditInstance = { localRepo in
        return ProfileEditRepository(localData: localRepo)
    }
}

extension ProfileEditRepository: ProfileEditRepositoryProtocol {
    func saveEmail(with email: String, forKey: String) {
        self.localData.saveEmail(with: email, forKey: forKey)
    }
    
    func saveName(with name: String, forKey: String) {
        self.localData.saveName(with: name, forKey: forKey)
    }
    
    func retriveEmail(with forKey: String, completion: @escaping (String) -> Void) {
        self.localData.retriveEmail(with: forKey) { data in
            completion(data)
        }
    }
    
    func retriveName(with forKey: String, completion: @escaping (String) -> Void) {
        self.localData.retriveName(with: forKey) { data in
            completion(data)
        }
    }
    
    func saveImage(with image: UIImage) {
        self.localData.saveImage(with: image)
    }
    
    func retriveImage(_ completion: @escaping (UIImage) -> Void) {
        self.localData.retriveImage { data in
            completion(data)
        }
    }
}

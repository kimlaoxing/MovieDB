import Foundation
import UIKit

protocol ProfileEditLocalDataSourceProtocol: AnyObject {
   func saveEmail(with email: String, forKey: String)
   func saveName(with name: String, forKey: String)
   func retriveEmail(with forKey: String, completion: @escaping(String) -> Void)
   func retriveName(with forKey: String, completion: @escaping(String) -> Void)
   func saveImage(with image: UIImage)
   func retriveImage(_ completion: @escaping(UIImage) -> Void)
}

final class ProfileEditLocalDataSource: NSObject {
    private override init () {}
    
    static let sharedInstance: ProfileEditLocalDataSource = ProfileEditLocalDataSource()
}

extension ProfileEditLocalDataSource: ProfileEditLocalDataSourceProtocol {
    func saveEmail(with email: String, forKey: String) {
        UserDefaults.standard.set(email, forKey: forKey)
    }
    
    func saveName(with name: String, forKey: String) {
        UserDefaults.standard.set(name, forKey: forKey)
    }
    
    func retriveEmail(with forKey: String, completion: @escaping(String) -> Void) {
        if let data = UserDefaults.standard.string(forKey: forKey) {
            completion(data)
        } else {
            completion("kimlaoxing@gmail.com")
        }
    }
    
    func retriveName(with forKey: String, completion: @escaping(String) -> Void) {
        if let data = UserDefaults.standard.string(forKey: forKey) {
            completion(data)
        } else {
            completion("Kevin Maulana")
        }
    }
    
    func saveImage(with image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: ProfileViewForKey.profileImage)
    }
    
    func retriveImage(_ completion: @escaping(UIImage) -> Void) {
        if let data = UserDefaults.standard.data(forKey: ProfileViewForKey.profileImage) {
            let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
            if let image = UIImage(data: decoded) {
                completion(image)
            }
        } else {
            let image = Resources.imageAssets("profileImage")
            completion(image ?? UIImage())
        }
    }
}

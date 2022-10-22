import Foundation
import UIKit

protocol ProfileEditLocal {
    mutating func saveEmail(with email: String, forKey: String)
    mutating func saveName(with name: String, forKey: String)
    mutating func retriveEmail(with forKey: String, completion: @escaping(String) -> Void)
    mutating func retriveName(with forKey: String, completion: @escaping(String) -> Void)
    mutating func saveImage(with image: UIImage)
    mutating func retriveImage(_ completion: @escaping(UIImage) -> Void)
}

struct ProfileEditLocalData: ProfileEditLocal {
    
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
            completion("UnRegist")
        }
    }
    
    func retriveName(with forKey: String, completion: @escaping(String) -> Void) {
        if let data = UserDefaults.standard.string(forKey: forKey) {
            completion(data)
        } else {
            completion("UnRegist")
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
            let image = UIImage(systemName: "house.circle.fill")
            completion(image ?? UIImage())
        }
    }
}

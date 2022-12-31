import UIKit

class Resources: NSObject {
    static func localized(_ wording: String) -> String {
        let lang = UserDefaults.standard.string(forKey: APPS_LANGUAGE_KEY)
        let bundle = Bundle(for: Resources.self)
        guard let url = bundle.url(forResource: lang, withExtension: "lproj") else { return "" }
        let path = Bundle(url: url)
        
        return NSLocalizedString(wording, tableName: nil, bundle: path ?? Bundle.main, value: "", comment: "")
    }
    
    static func imageAssets(_ imageName: String) -> UIImage? {
        return UIImage(named: imageName, in: Bundle(for: self.classForCoder()), compatibleWith: nil)
    }
}

public enum AppsLanguage: String {
    case id
    case en
}

public let APPS_LANGUAGE_KEY = "APPS_LANGUAGE_KEY"

public struct LanguageHelper {
    
    public static let shared = LanguageHelper()
    
    public init() {}
    
    public func setLanguage(to lang: AppsLanguage) {
        UserDefaults.standard.set(lang.rawValue, forKey: APPS_LANGUAGE_KEY)
        UserDefaults.standard.synchronize()
    }
    
    public func currentLanguage() -> AppsLanguage {
        if let string = UserDefaults.standard.string(forKey: APPS_LANGUAGE_KEY) {
            return AppsLanguage(rawValue: string) ?? .en
        }
        return .en
    }
    
}
